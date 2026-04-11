import 'package:injectable/injectable.dart';
import '../models/shipment_model.dart';

abstract class TrackingRepository {
  ShipmentModel? get currentShipment;
  Future<ShipmentModel?> searchShipment(String trackingNumber);
}

@LazySingleton(as: TrackingRepository)
class TrackingRepositoryImpl implements TrackingRepository {
  ShipmentModel? _currentShipment;

  @override
  ShipmentModel? get currentShipment => _currentShipment;

  @override
  Future<ShipmentModel?> searchShipment(String trackingNumber) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // In a real app, you would fetch from API based on trackingNumber
    // For now, we return our dummy shipment
    _currentShipment = ShipmentModel.dummyShipment;
    return _currentShipment;
  }
}
