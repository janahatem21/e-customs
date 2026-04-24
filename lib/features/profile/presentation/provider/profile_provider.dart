import 'dart:async';
import 'package:e_customs/core/models/user_model.dart';
import 'package:e_customs/core/routes/app_router.dart';
import 'package:e_customs/features/auth/data/repositories/auth_repository.dart';
import 'package:e_customs/features/profile/data/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;

  UserModel? _user;
  StreamSubscription<UserModel?>? _userSubscription;

  ProfileProvider(this._profileRepository, this._authRepository) {
    _initProfileStream();
  }

  void _initProfileStream() {
    _userSubscription?.cancel();
    _userSubscription = _profileRepository.getProfileStream().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  UserModel? get user => _user;
  String get userName => _user?.name ?? "Guest";
  String get userEmail => _user?.email ?? "Not logged in";
  String? get passportId => _user?.passportId;
  bool get isVerified => true; // Still mock for now
  String get avatarUrl => "https://i.pravatar.cc/300";

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  int _shakeCounter = 0;
  int get shakeCounter => _shakeCounter;

  Future<bool> updateProfile({
    required String name,
    required String email,
    String? passportId,
  }) async {
    if (_user == null) return false;

    _isSaving = true;
    notifyListeners();

    try {
      final updatedUser = UserModel(
        id: _user!.id,
        name: name,
        email: email,
        passportId: passportId,
        createdAt: _user!.createdAt,
      );

      await _profileRepository.updateProfile(updatedUser);
      _isSaving = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isSaving = false;
      notifyListeners();
      return false;
    }
  }

  void triggerShake() {
    _shakeCounter++;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      _shakeCounter = 0;
      notifyListeners();
    });
  }

  Future<void> logout(BuildContext context) async {
    await _authRepository.logout();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouter.login,
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
