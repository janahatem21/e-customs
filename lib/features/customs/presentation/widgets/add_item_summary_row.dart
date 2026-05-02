import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class AddItemSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const AddItemSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.greyText, fontSize: 14),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.blackText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color: AppColors.lightGrey.withValues(alpha: 0.3),
            height: 1,
          ),
      ],
    );
  }
}
