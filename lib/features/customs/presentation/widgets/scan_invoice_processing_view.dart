import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/constants/app_colors.dart';

class ScanInvoiceProcessingView extends StatelessWidget {
  const ScanInvoiceProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey('processing'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.primary,
            ),
          ).animate().scale().fadeIn(),
          const SizedBox(height: 24),
          const Text(
            'Processing invoice...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 8),
          Text(
            'Extracting data using AI',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.greyText.withValues(alpha: 0.7),
            ),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }
}
