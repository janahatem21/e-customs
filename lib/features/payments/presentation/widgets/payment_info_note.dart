import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PaymentInfoNote extends StatelessWidget {
  final String invoiceNumber;
  final double declaredValue;

  const PaymentInfoNote({
    super.key,
    required this.invoiceNumber,
    required this.declaredValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Information Note",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      height: 1.5,
                      color: AppColors.subtitleColor,
                    ),
                    children: [
                      const TextSpan(text: "Fees are calculated based on the declared shipment value of "),
                      TextSpan(
                        text: "€${declaredValue.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blackText),
                      ),
                      const TextSpan(text: " as per invoice "),
                      TextSpan(
                        text: "#$invoiceNumber",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blackText),
                      ),
                      const TextSpan(text: "."),
                    ],
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
