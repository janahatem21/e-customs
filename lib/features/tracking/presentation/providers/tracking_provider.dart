import 'package:flutter/material.dart';
import '../../data/models/shipment_model.dart';

class TrackingProvider extends ChangeNotifier {
  ShipmentModel? _currentShipment;
  ShipmentModel? get currentShipment => _currentShipment;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController searchController = TextEditingController(text: 'EC-882944012');

  void trackShipment(String trackingNumber) async {
    if (trackingNumber.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // For now, always return the same dummy data if searching for the same number
    // or just return dummy data for any search for UI demonstration.
    _currentShipment = ShipmentModel.dummyShipment;
    
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
