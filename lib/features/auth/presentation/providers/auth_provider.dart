import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/auth_repository.dart';
import '../../../../core/providers/user_provider.dart';

@injectable
class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserProvider _userProvider;

  AuthProvider(this._authRepository, this._userProvider);

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get agreeToTerms => _agreeToTerms;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void toggleAgreeToTerms() {
    _agreeToTerms = !_agreeToTerms;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    setLoading(true);
    try {
      final user = await _authRepository.login(email, password);
      _userProvider.setUser(user);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> register(String name, String email, String password) async {
    setLoading(true);
    try {
      final user = await _authRepository.register(name, email, password);
      _userProvider.setUser(user);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    setLoading(true);
    try {
      final user = await _authRepository.signInWithGoogle();
      _userProvider.setUser(user);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> forgotPassword(String email) async {
    setLoading(true);
    try {
      await _authRepository.sendPasswordResetEmail(email);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _userProvider.logout();
  }
}
