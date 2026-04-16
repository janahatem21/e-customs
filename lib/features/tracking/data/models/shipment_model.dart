class TrackingStepModel {
  final String title;
  final String time;
  final String location;
  final String details;
  final String date;
  final bool isCompleted;

  const TrackingStepModel({
    required this.title,
    required this.time,
    required this.location,
    required this.details,
    required this.date,
    this.isCompleted = false,
  });
}

class ShipmentModel {
  final String trackingNumber;
  final String status;
  final String estimatedArrival;
  final String currentLocation;
  final String origin;
  final String destination;
  final double progress; // 0.0 to 1.0
  final List<TrackingStepModel> steps;

  const ShipmentModel({
    required this.trackingNumber,
    required this.status,
    required this.estimatedArrival,
    required this.currentLocation,
    required this.origin,
    required this.destination,
    required this.progress,
    required this.steps,
  });

  static ShipmentModel dummyShipment = ShipmentModel(
    trackingNumber: 'EC-882944012',
    status: 'In Transit',
    estimatedArrival: 'Oct 26, 2023',
    currentLocation: 'Los Angeles, CA',
    origin: 'Shanghai (Origin)',
    destination: 'Los Angeles (Dest)',
    progress: 0.75,
    steps: [
      const TrackingStepModel(
        title: 'Customs Cleared',
        time: '10:30 AM',
        location: 'Los Angeles, USA',
        details: 'Package has cleared customs and is ready for local transport.',
        date: 'Oct 20, 2023',
        isCompleted: true,
      ),
      const TrackingStepModel(
        title: 'In Transit',
        time: '04:15 PM',
        location: 'Pacific Ocean',
        details: 'Shipment is currently moving through the international transit hub.',
        date: 'Oct 18, 2023',
        isCompleted: true,
      ),
      const TrackingStepModel(
        title: 'Shipment Picked Up',
        time: '09:00 AM',
        location: 'Shanghai, China',
        details: 'The item has been picked up by the international courier service.',
        date: 'Oct 15, 2023',
        isCompleted: true,
      ),
      const TrackingStepModel(
        title: 'Label Created',
        time: '02:45 PM',
        location: 'Shanghai, China',
        details: 'Shipping label has been created and package is awaiting pickup.',
        date: 'Oct 14, 2023',
        isCompleted: true,
      ),
    ],
  );
}
