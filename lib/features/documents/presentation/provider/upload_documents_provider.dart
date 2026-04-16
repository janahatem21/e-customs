import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadDocumentsProvider extends ChangeNotifier {
  int currentStep = 1;
  String? productName;
  String? category;
  int quantity = 1;
  String? originCountry;
  double declaredValue = 0.0;
  bool isPackingListAdded = false;

  void setProductName(String name) {
    productName = name;
    notifyListeners();
  }

  void setCategory(String? value) {
    category = value;
    notifyListeners();
  }

  void setQuantity(int value) {
    quantity = value;
    notifyListeners();
  }

  void setOriginCountry(String? value) {
    originCountry = value;
    notifyListeners();
  }

  void setDeclaredValue(double value) {
    declaredValue = value;
    notifyListeners();
  }

  void togglePackingList() {
    isPackingListAdded = !isPackingListAdded;
    notifyListeners();
  }

  void nextStep() {
    if (currentStep < 2) {
      currentStep++;
      notifyListeners();
    }
  }
}
