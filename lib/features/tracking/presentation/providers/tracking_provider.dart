import 'package:e_customs/features/tracking/data/models/shipment_model.dart';
import 'package:e_customs/features/tracking/data/repositories/tracking_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackingProvider extends ChangeNotifier {
  final TrackingRepository _repository;

  TrackingProvider(this._repository);

  ShipmentModel? get currentShipment => _repository.currentShipment;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController searchController = TextEditingController(
    text: 'EC-882944012',
  );

  Future<void> searchShipment(String trackingNumber) async {
    if (trackingNumber.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    await _repository.searchShipment(trackingNumber);

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
