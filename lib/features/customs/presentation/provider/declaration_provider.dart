import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/declaration_model.dart';
import '../../domain/usecases/get_active_declaration_usecase.dart';
import '../../domain/usecases/create_declaration_usecase.dart';

enum DeclarationState { idle, loading, success, error }

@lazySingleton
class DeclarationProvider extends ChangeNotifier {
  final GetActiveDeclarationUseCase _getActiveDeclarationUseCase;
  final CreateDeclarationUseCase _createDeclarationUseCase;

  DeclarationProvider(
    this._getActiveDeclarationUseCase,
    this._createDeclarationUseCase,
  );

  DeclarationModel? _currentDeclaration;
  DeclarationModel? get currentDeclaration => _currentDeclaration;

  DeclarationState _state = DeclarationState.idle;
  DeclarationState get state => _state;

  String? _currentDeclarationId;
  String? get currentDeclarationId => _currentDeclarationId;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _state == DeclarationState.loading;

  Future<String?> ensureActiveDeclaration(String userId) async {
    _state = DeclarationState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final active = await _getActiveDeclarationUseCase(userId);
      
      if (active != null) {
        _currentDeclaration = active as DeclarationModel;
        _currentDeclarationId = active.id;
        _state = DeclarationState.success;
        notifyListeners();
        return active.id;
      }
      
      // If no active declaration, we return null so the UI can decide to navigate to CreateDeclarationScreen
      _state = DeclarationState.idle;
      notifyListeners();
      return null;
    } catch (e) {
      _state = DeclarationState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<String?> createNewDeclaration(String userId) async {
    _state = DeclarationState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final id = await _createDeclarationUseCase(userId);
      _currentDeclarationId = id;
      _state = DeclarationState.success;
      notifyListeners();
      return id;
    } catch (e) {
      _state = DeclarationState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }
}
