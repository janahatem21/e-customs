import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class VerificationCard extends StatelessWidget {
  const VerificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.gradientMid.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              IconsaxPlusLinear.shield_tick,
              size: 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Secure Customs Verification',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Your shipment is monitored and verified by E-Customs for regulatory compliance.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.subtitleColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
