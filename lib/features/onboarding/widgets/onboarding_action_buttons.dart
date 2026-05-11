import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_router.dart';
import '../providers/onboarding_provider.dart';

class OnboardingActionButtons extends StatelessWidget {
  const OnboardingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child:
            provider.isLastPage
                ? const _LastPageActions()
                : provider.isFirstPage
                ? const _FirstPageActions()
                : const _MiddlePageActions(),
      ),
    );
  }
}

class _FirstPageActions extends StatelessWidget {
  const _FirstPageActions();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnboardingProvider>();
    return Column(
      children: [
        _MainButton(
          text: AppStrings.getStarted,
          onPressed: () => provider.nextPage(context, AppRouter.login),
          icon: Icons.arrow_forward_rounded,
        ),
        // TextButton(
        //   onPressed: () => provider.skip(context, AppRouter.login),
        //   child: const Text(AppStrings.skipToLogin),
        // ),
      ],
    );
  }
}

class _MiddlePageActions extends StatelessWidget {
  const _MiddlePageActions();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnboardingProvider>();
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: provider.previousPage,
            child: const Text(AppStrings.back),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _MainButton(
            text: AppStrings.next,
            onPressed: () => provider.nextPage(context, AppRouter.login),
            icon: Icons.chevron_right_rounded,
          ),
        ),
      ],
    );
  }
}

class _LastPageActions extends StatelessWidget {
  const _LastPageActions();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnboardingProvider>();
    return Column(
      children: [
        _MainButton(
          text: AppStrings.getStarted,
          onPressed: () => provider.nextPage(context, AppRouter.login),
          icon: Icons.check_circle_outline_rounded,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shield_rounded,
              size: 14,
              color: AppColors.subtitleColor,
            ),
            const SizedBox(width: 6),
            Text(
              AppStrings.secureEncryption.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.subtitleColor,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;

  const _MainButton({
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(width: 10),
            Icon(icon, size: 20),
          ],
        ),
      ),
    );
  }
}
