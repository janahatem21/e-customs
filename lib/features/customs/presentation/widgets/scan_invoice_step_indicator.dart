import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class ScanInvoiceStepIndicator extends StatelessWidget {
  final int step;

  const ScanInvoiceStepIndicator({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          _ProgressDot(active: true),
          _ProgressLine(active: step >= 2),
          _ProgressDot(active: step >= 2),
          _ProgressLine(active: step >= 3),
          _ProgressDot(active: step >= 3),
        ],
      ),
    );
  }
}

class _ProgressDot extends StatelessWidget {
  final bool active;

  const _ProgressDot({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color:
            active
                ? AppColors.primary
                : AppColors.lightGrey.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ProgressLine extends StatelessWidget {
  final bool active;

  const _ProgressLine({required this.active});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color:
            active
                ? AppColors.primary
                : AppColors.lightGrey.withValues(alpha: 0.3),
      ),
    );
  }
}
