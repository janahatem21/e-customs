import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
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

  // Future auth methods (placeholders)
  Future<void> login(String email, String password) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    setLoading(false);
  }

  Future<void> register(String name, String email, String password) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    setLoading(false);
  }

  Future<void> forgotPassword(String email) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    setLoading(false);
  }
}
