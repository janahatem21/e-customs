import '../models/tracking_step_model.dart';

const List<TrackingStep> trackingSteps = [
  TrackingStep(
    title: 'Shipment Created',
    time: '09:15 AM',
    location: 'Shanghai, China',
    details: 'Shipment data received and label generated.',
    date: 'Oct 20, 2023',
    icon: 'CheckCircle2',
    status: 'done',
  ),
  TrackingStep(
    title: 'Departed Origin Facility',
    time: '06:40 PM',
    location: 'Shanghai Export Hub',
    details: 'Package departed from the export processing center.',
    date: 'Oct 21, 2023',
    icon: 'Truck',
    status: 'done',
  ),
  TrackingStep(
    title: 'Customs Verification',
    time: '11:10 AM',
    location: 'Los Angeles, CA',
    details: 'Shipment is currently under customs review and inspection.',
    date: 'Oct 24, 2023',
    icon: 'ShieldCheck',
    status: 'current',
  ),
  TrackingStep(
    title: 'In Local Transit',
    time: 'Pending',
    location: 'Los Angeles Distribution Center',
    details: 'Shipment will move to the destination facility after clearance.',
    date: 'Oct 25, 2023',
    icon: 'Search',
    status: 'upcoming',
  ),
  TrackingStep(
    title: 'Out for Final Delivery',
    time: 'Pending',
    location: 'Destination City',
    details: 'Final delivery is being prepared.',
    date: 'Oct 26, 2023',
    icon: 'Globe',
    status: 'upcoming',
  ),
];