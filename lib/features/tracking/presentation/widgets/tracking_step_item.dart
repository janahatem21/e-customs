import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/shipment_model.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TrackingStepItem extends StatelessWidget {
  final TrackingStepModel step;
  final bool isLast;

  const TrackingStepItem({
    super.key,
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: step.isCompleted ? AppColors.primary : AppColors.white,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: step.isCompleted
                    ? const Icon(
                        Icons.check,
                        size: 10,
                        color: AppColors.white,
                      )
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: step.isCompleted 
                          ? AppColors.primary 
                          : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        step.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.blackText,
                        ),
                      ),
                      Text(
                        step.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.subtitleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        IconsaxPlusLinear.location,
                        size: 14,
                        color: AppColors.subtitleColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        step.location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.subtitleColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step.details,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: AppColors.blackText.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.date,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.subtitleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
