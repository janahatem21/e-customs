import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class OnboardingSecondPage extends StatelessWidget {
  const OnboardingSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey(1),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 224,
          child: Image.asset(
            AppAssets.onboarding2,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          AppStrings.onboardingTitle2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.25,
            color: AppColors.blackText,
          ),
        ),
        const SizedBox(height: 12),
        const SizedBox(
          width: 300,
          child: Text(
            AppStrings.onboardingDesc2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: AppColors.subtitleColor,
            ),
          ),
        ),
      ],
    );
  }
}