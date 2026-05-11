import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/declaration_model.dart';
import '../../domain/usecases/calculate_customs_usecase.dart';
import '../../domain/usecases/get_items_usecase.dart';
import '../../domain/usecases/get_declaration_by_id_usecase.dart';
import '../../domain/usecases/confirm_calculation_usecase.dart';
import '../../domain/entities/item_entity.dart';
import '../../../../core/services/notification_service.dart';

enum CalculateState { idle, loading, success, error, confirming }

@injectable
class CalculateProvider extends ChangeNotifier {
  final CalculateCustomsUseCase _calculateCustomsUseCase;
  final GetItemsUseCase _getItemsUseCase;
  final GetDeclarationByIdUseCase _getDeclarationByIdUseCase;
  final ConfirmCalculationUseCase _confirmCalculationUseCase;
  final NotificationService _notificationService;

  CalculateProvider(
    this._calculateCustomsUseCase,
    this._getItemsUseCase,
    this._getDeclarationByIdUseCase,
    this._confirmCalculationUseCase,
    this._notificationService,
  );

  CalculateState _state = CalculateState.idle;
  CalculateState get state => _state;

  List<ItemEntity> _items = [];
  List<ItemEntity> get items => _items;

  DeclarationModel? _declaration;
  DeclarationModel? get declaration => _declaration;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _state == CalculateState.loading;
  bool get isConfirming => _state == CalculateState.confirming;
  bool get isSuccess => _state == CalculateState.success;
  bool get isError => _state == CalculateState.error;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> calculate({
    required String userId,
    required String declarationId,
  }) async {
    _state = CalculateState.loading;
    _errorMessage = null;
    _items = [];
    notifyListeners();

    try {
      // 1. Trigger calculation (now keeps status as draft)
      await _calculateCustomsUseCase(
        userId: userId,
        declarationId: declarationId,
      );

      // 2. Fetch items to show in summary
      _items = await _getItemsUseCase(
        userId: userId,
        declarationId: declarationId,
      );

      // 3. Fetch declaration to show totals
      final result = await _getDeclarationByIdUseCase(userId, declarationId);
      if (result != null) {
        _declaration = result as DeclarationModel;
      }

      _state = CalculateState.success;
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      _state = CalculateState.error;
      _errorMessage = e.toString();
      _isInitialized = true;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> confirm({
    required String userId,
    required String declarationId,
  }) async {
    _state = CalculateState.confirming;
    notifyListeners();

    try {
      await _confirmCalculationUseCase(userId, declarationId);

      // Trigger Notification
      await _notificationService.notifyCustomsCalculated(userId, declarationId);

      _state = CalculateState.success;
      notifyListeners();
    } catch (e) {
      _state = CalculateState.error;
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  void markAsInitialized() {
    _isInitialized = true;
    notifyListeners();
  }

  void reset() {
    _state = CalculateState.idle;
    _errorMessage = null;
    _items = [];
    _isInitialized = false;
    notifyListeners();
  }
}
