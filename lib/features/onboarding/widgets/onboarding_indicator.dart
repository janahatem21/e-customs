import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/onboarding_provider.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        provider.totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: provider.currentPage == index ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: provider.currentPage == index
                ? AppColors.primary
                : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}