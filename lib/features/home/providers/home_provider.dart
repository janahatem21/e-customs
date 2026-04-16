import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Add any home-specific logic here later (e.g. fetching recent updates)
}
