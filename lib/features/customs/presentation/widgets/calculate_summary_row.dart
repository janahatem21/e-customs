import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CalculateSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isSmall;

  const CalculateSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isSmall ? 13 : 15,
            color: isSmall ? AppColors.greyText : AppColors.blackText,
            fontWeight: isSmall ? FontWeight.w500 : FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isSmall ? 14 : 16,
            color: AppColors.blackText,
            fontWeight: isSmall ? FontWeight.w600 : FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
