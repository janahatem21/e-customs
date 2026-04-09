import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.gradientMid,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.shield_outlined,
            size: 28,
            color: AppColors.blackText,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          AppStrings.appName,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.subtitleColor,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          AppStrings.joinTheGateway,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.blackText,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          AppStrings.registerSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.subtitleColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}