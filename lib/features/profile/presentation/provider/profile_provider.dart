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

  void updateProfile({String? name, String? email}) {
    if (name != null) _userName = name;
    if (email != null) _userEmail = email;
    notifyListeners();
  }

  void logout(BuildContext context) {
    // Implement logout logic here
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
