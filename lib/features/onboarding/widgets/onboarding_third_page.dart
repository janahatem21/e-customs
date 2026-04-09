import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class OnboardingThirdPage extends StatelessWidget {
  const OnboardingThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey(2),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 256,
          height: 224,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 192,
                height: 176,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.lightGrey),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 16,
                      offset: Offset(0, 8),
                      color: Color(0x14000000),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.description_outlined,
                            size: 14,
                            color: AppColors.subtitleColor,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 96,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: 144,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.gradientLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.lightGrey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.verified_user_outlined,
                            size: 26,
                            color: AppColors.subtitleColor,
                          ),
                          SizedBox(height: 4),
                          Text(
                            AppStrings.verified,
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: 144,
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.credit_card,
                            size: 14,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 48,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.subtitleColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 14,
                top: 42,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.lightGrey),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        color: Color(0x12000000),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    size: 16,
                    color: AppColors.subtitleColor,
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 112,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.lightGrey),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        color: Color(0x12000000),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    size: 16,
                    color: AppColors.subtitleColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          AppStrings.onboardingTitle3,
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
            AppStrings.onboardingDesc3,
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