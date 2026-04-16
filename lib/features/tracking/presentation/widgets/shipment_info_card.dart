import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/shipment_model.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShipmentInfoCard extends StatelessWidget {
  final ShipmentModel shipment;

  const ShipmentInfoCard({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  IconsaxPlusLinear.box,
                  size: 20,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TRACKING ID',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white54,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      shipment.trackingNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  shipment.status,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoBlock(
                label: 'Estimated Arrival',
                value: shipment.estimatedArrival,
                alignEnd: false,
              ),
              _InfoBlock(
                label: 'Current Location',
                value: shipment.currentLocation,
                alignEnd: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                shipment.origin,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                shipment.destination,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Background track
              Container(
                width: double.infinity,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Animated Progress Bar and Icon
              Animate(
                effects: [
                  CustomEffect(
                    duration: 1200.ms,
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      final currentProgress = value * shipment.progress;
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          FractionallySizedBox(
                            widthFactor: currentProgress.clamp(0, 1),
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          // Moving Icon
                          Positioned(
                            left:
                                (MediaQuery.of(context).size.width - 88) *
                                    currentProgress -
                                12,
                            top: -8,
                            child: const Icon(
                              IconsaxPlusBold.truck_fast,
                              size: 22,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;
  final bool alignEnd;

  const _InfoBlock({
    required this.label,
    required this.value,
    required this.alignEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 9,
            letterSpacing: 1.2,
            color: Colors.white54,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
