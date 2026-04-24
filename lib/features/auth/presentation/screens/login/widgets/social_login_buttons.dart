import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/routes/app_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.lightGrey)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppStrings.orContinueWith,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.subtitleColor,
                  fontSize: 11,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.lightGrey)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _SocialButton(
                onPressed: authProvider.isLoading
                    ? () {}
                    : () async {
                      try {
                        await authProvider.signInWithGoogle();
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRouter.layout,
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      }
                    },
                icon: AppAssets.googleLogo,
                label: AppStrings.google,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _SocialButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Github Login not implemented')),
                  );
                },
                icon: AppAssets.githubLogo,
                label: AppStrings.github,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final String label;

  const _SocialButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: const BorderSide(color: AppColors.lightGrey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, height: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.blackText,
            ),
          ),
        ],
      ),
    );
  }
}
