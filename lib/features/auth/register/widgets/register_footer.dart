import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';

class RegisterFooter extends StatelessWidget {
  final VoidCallback onLoginInstead;

  const RegisterFooter({
    super.key,
    required this.onLoginInstead,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.lightGrey,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                AppStrings.orConnectWith,
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  color: AppColors.subtitleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.lightGrey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          AppStrings.alreadyHaveAccount,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.subtitleColor,
          ),
        ),
        const SizedBox(height: 12),
        AppButton(
          text: AppStrings.loginInstead,
          variant: AppButtonVariant.outline,
          onPressed: onLoginInstead,
        ),
        const SizedBox(height: 20),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.shield_outlined,
                size: 14,
                color: AppColors.subtitleColor,
              ),
              SizedBox(width: 6),
              Flexible(
                child: Text(
                  AppStrings.secureRegistration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.subtitleColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}