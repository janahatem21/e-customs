import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../models/user_model.dart';
import '../services/firebase_services.dart';

@singleton
class UserProvider extends ChangeNotifier {
  final FirebaseServices _firebaseServices;
  UserModel? _user;
  bool _isLoading = false;

  UserProvider(this._firebaseServices) {
    fetchCurrentUser();
  }

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> fetchCurrentUser() async {
    final firebaseUser = _firebaseServices.auth.currentUser;
    if (firebaseUser != null) {
      _isLoading = true;
      notifyListeners();
      try {
        final doc =
            await _firebaseServices.firestore
                .collection('users')
                .doc(firebaseUser.uid)
                .get();

        if (doc.exists && doc.data() != null) {
          _user = UserModel.fromFirestore(doc.data()!, doc.id);
        }
      } catch (e) {
        debugPrint('Error fetching user: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> updatePassportId(String passportId) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseServices.firestore
          .collection('users')
          .doc(_user!.id)
          .update({'passportId': passportId});

      _user = _user!.copyWith(passportId: passportId);
    } catch (e) {
      debugPrint('Error updating passport ID: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
