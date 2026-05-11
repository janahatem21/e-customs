import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/constants/app_colors.dart';

class CalculateTrustIndicator extends StatelessWidget {
  const CalculateTrustIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.securityGreen.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.securityGreen.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            IconsaxPlusBold.shield_tick,
            color: AppColors.securityGreen,
            size: 24,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Official Calculation',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.securityGreen,
                  ),
                ),
                Text(
                  'Fees are calculated based on current government regulations and tariff rates.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.securityGreenDark,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
