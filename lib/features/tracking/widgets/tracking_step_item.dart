import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../data/tracking_steps.dart';
import '../models/tracking_step_model.dart';

class TrackingStepItem extends StatelessWidget {
  final TrackingStep step;
  final bool isLast;

  const TrackingStepItem({
    super.key,
    required this.step,
    required this.isLast,
  });

  bool get isCurrent => step.status == 'current';

  Widget _buildIcon() {
    final Color iconColor =
    isCurrent ? AppColors.primary : AppColors.blackText;

    final Color bgColor =
    isCurrent ? AppColors.gradientMid : AppColors.gradientMid;

    IconData iconData;

    switch (step.icon) {
      case 'CheckCircle2':
        iconData = Icons.check_circle_outline_rounded;
        break;
      case 'Truck':
        iconData = Icons.local_shipping_outlined;
        break;
      case 'ShieldCheck':
        iconData = Icons.shield_outlined;
        break;
      case 'Search':
        iconData = Icons.remove_red_eye_outlined;
        break;
      case 'Globe':
        iconData = Icons.public_outlined;
        break;
      default:
        iconData = Icons.radio_button_unchecked;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Icon(
        iconData,
        size: 16,
        color: iconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildIcon(),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: AppColors.lightGrey,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackText,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        step.time,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.subtitleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    step.location,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.details,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.45,
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.date,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackText,
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