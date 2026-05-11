import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_action_buttons.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_page_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              isVisible: !provider.isLastPage,
              onSkip: () => provider.skip(context, AppRouter.login),
            ),
            Expanded(
              child: PageView.builder(
                controller: provider.pageController,
                itemCount: provider.totalPages,
                onPageChanged: provider.onPageChanged,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    model: provider.onboardingItems[index],
                  );
                },
              ),
            ),
            const OnboardingIndicator(),
            const SizedBox(height: 16),
            const OnboardingActionButtons(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onSkip;

  const _TopBar({required this.isVisible, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isVisible ? 1.0 : 0.0,
      child: IgnorePointer(
        ignoring: !isVisible,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: onSkip,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.subtitleColor,
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
