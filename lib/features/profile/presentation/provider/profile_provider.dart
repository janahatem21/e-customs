import 'package:e_customs/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileProvider extends ChangeNotifier {
  String _userName = "John Doe";
  String _userEmail = "john.doe@customs.gov";
  final bool _isVerified = true;
  final String _avatarUrl = "https://i.pravatar.cc/300";

  String get userName => _userName;
  String get userEmail => _userEmail;
  bool get isVerified => _isVerified;
  String get avatarUrl => _avatarUrl;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  int _shakeCounter = 0;
  int get shakeCounter => _shakeCounter;

  Future<bool> updateProfile({
    required String name,
    required String email,
  }) async {
    _isSaving = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _userName = name;
    _userEmail = email;
    _isSaving = false;
    notifyListeners();
    return true;
  }

  void triggerShake() {
    _shakeCounter++;
    notifyListeners();
    // Reset after animation
    Future.delayed(const Duration(milliseconds: 500), () {
      _shakeCounter = 0;
      notifyListeners();
    });
  }

  void logout(BuildContext context) {
    // Implement logout logic here
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.login,
      (route) => false,
    );
  }
}
