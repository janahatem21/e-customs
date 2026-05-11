import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/constants/app_colors.dart';

class PaymentSecurityIndicator extends StatelessWidget {
  const PaymentSecurityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          IconsaxPlusBold.lock,
          color: AppColors.securityGreen,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          'Secure 256-bit SSL Encrypted Payment',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.securityGreen,
          ),
        ),
      ],
    );
  }
}
