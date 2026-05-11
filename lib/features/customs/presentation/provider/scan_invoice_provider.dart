import 'dart:io';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/ocr_item_entity.dart';
import '../../domain/usecases/scan_invoice_usecase.dart';
import '../../domain/usecases/add_item_usecase.dart';
import '../../data/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/services/firebase_services.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/services/notification_service.dart';
import '../provider/declaration_provider.dart';
import '../../../../core/errors/exceptions.dart';

enum OcrState { idle, loading, success, error }

@injectable
class ScanInvoiceProvider extends ChangeNotifier {
  final ScanInvoiceUseCase _scanInvoiceUseCase;
  final AddItemsUseCase _addItemsUseCase;
  final NotificationService _notificationService;
  final ImagePicker _picker = ImagePicker();

  ScanInvoiceProvider(
    this._scanInvoiceUseCase,
    this._addItemsUseCase,
    this._notificationService,
  );

  OcrState _state = OcrState.idle;
  OcrState get state => _state;

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  List<OcrItemEntity> _items = [];
  List<OcrItemEntity> get items => _items;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _state == OcrState.loading;

  Future<void> pickFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      _selectedImage = File(photo.path);
      notifyListeners();
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> scanInvoice() async {
    if (_selectedImage == null) return;

    _state = OcrState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await _scanInvoiceUseCase(_selectedImage!.path);
      _items = results;
      _state = OcrState.success;
      notifyListeners();
    } on NoTextDetectedException {
      _state = OcrState.error;
      _errorMessage =
          "Could not analyze this receipt. Please try another image or add items manually.";
      notifyListeners();
    } catch (e) {
      _state = OcrState.error;
      _errorMessage =
          "Automatic receipt analysis is currently unavailable. Please add your items manually.";
      dev.log("Scan Invoice Error: $e", name: "ScanInvoiceProvider");
      notifyListeners();
    }
  }

  void updateItem(
    int index, {
    String? name,
    double? price,
    int? quantity,
    String? category,
  }) {
    if (index >= 0 && index < _items.length) {
      final current = _items[index];
      _items[index] = OcrItemEntity(
        name: name ?? current.name,
        price: price ?? current.price,
        currency: current.currency,
        quantity: quantity ?? current.quantity,
        category: category ?? current.category,
      );
      notifyListeners();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  Future<bool> confirmAndSave(
    BuildContext context,
    DeclarationProvider declarationProvider,
  ) async {
    if (_items.isEmpty) return false;

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userId = getIt<FirebaseServices>().currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      final declarationId = await declarationProvider.ensureActiveDeclaration(
        userId,
      );
      if (declarationId == null) {
        throw Exception('Could not ensure active declaration');
      }

      final itemsToSave =
          _items
              .map(
                (item) => ItemModel(
                  name: item.name,
                  category: item.category ?? 'Other',
                  price: item.price,
                  quantity: item.quantity,
                  currency: item.currency ?? 'USD',
                  isExempted: false,
                  createdAt: Timestamp.now(),
                ),
              )
              .toList();

      await _addItemsUseCase(
        AddItemsParams(
          userId: userId,
          declarationId: declarationId,
          items: itemsToSave,
        ),
      );

      // Trigger Notification
      await _notificationService.notifyOCRImportSuccess(userId, declarationId);

      _isSaving = false;
      _state = OcrState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _isSaving = false;
      _state = OcrState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _selectedImage = null;
    _items = [];
    _state = OcrState.idle;
    _errorMessage = null;
    notifyListeners();
  }
}
