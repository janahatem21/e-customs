import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.verified_user_rounded,
              size: 14,
              color: Colors.green,
            ),
            const SizedBox(width: 8),
            Text(
              AppStrings.secureEncryption.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.subtitleColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.login),
          child: RichText(
            text: TextSpan(
              text: 'Already have an account? ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                  ),
              children: const [
                TextSpan(
                  text: AppStrings.signIn,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}