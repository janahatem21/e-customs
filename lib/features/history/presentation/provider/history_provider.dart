import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../customs/domain/entities/declaration_entity.dart';
import '../../../customs/domain/entities/item_entity.dart';
import '../../domain/usecases/get_declarations_usecase.dart';
import '../../domain/usecases/get_declaration_details_usecase.dart';
import '../../domain/usecases/get_declaration_items_usecase.dart';

@injectable
class HistoryProvider extends ChangeNotifier {
  final GetDeclarationsUseCase _getDeclarationsUseCase;
  final GetDeclarationDetailsUseCase _getDeclarationDetailsUseCase;
  final GetDeclarationItemsUseCase _getDeclarationItemsUseCase;

  HistoryProvider(
    this._getDeclarationsUseCase,
    this._getDeclarationDetailsUseCase,
    this._getDeclarationItemsUseCase,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<DeclarationEntity> _declarations = [];
  List<DeclarationEntity> get declarations => _declarations;

  DeclarationEntity? _selectedDeclaration;
  DeclarationEntity? get selectedDeclaration => _selectedDeclaration;

  List<ItemEntity> _declarationItems = [];
  List<ItemEntity> get declarationItems => _declarationItems;

  Future<void> loadDeclarations(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _declarations = await _getDeclarationsUseCase(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDeclarationDetails({
    required String userId,
    required String declarationId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _getDeclarationDetailsUseCase(
          userId: userId,
          declarationId: declarationId,
        ),
        _getDeclarationItemsUseCase(
          userId: userId,
          declarationId: declarationId,
        ),
      ]);

      _selectedDeclaration = results[0] as DeclarationEntity?;
      _declarationItems = results[1] as List<ItemEntity>;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
