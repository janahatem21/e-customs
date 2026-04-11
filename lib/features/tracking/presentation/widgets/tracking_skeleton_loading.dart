import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/widgets/app_card.dart';
import '../../data/models/shipment_model.dart';
import 'shipment_info_card.dart';
import 'tracking_step_item.dart';

class TrackingSkeletonLoading extends StatelessWidget {
  const TrackingSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: ShipmentInfoCard(shipment: ShipmentModel.dummyShipment),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: List.generate(
                  3,
                  (index) => TrackingStepItem(
                    step: ShipmentModel.dummyShipment.steps[0],
                    isLast: index == 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
