import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class RegulationNotice extends StatelessWidget {
  const RegulationNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline_rounded, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                "Import Regulation Notice",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Please ensure all details match your commercial invoice. Discrepancies may cause clearance delays or additional fines.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
