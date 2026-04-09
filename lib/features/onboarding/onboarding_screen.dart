import 'package:e_customs/features/onboarding/widgets/onboarding_action_buttons.dart';
import 'package:e_customs/features/onboarding/widgets/onboarding_first_page.dart';
import 'package:e_customs/features/onboarding/widgets/onboarding_indicator.dart';
import 'package:e_customs/features/onboarding/widgets/onboarding_second_page.dart';
import 'package:e_customs/features/onboarding/widgets/onboarding_third_page.dart';
import 'package:flutter/material.dart';
import '../../core/routes/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int totalPages = 3;
  int currentPage = 0;

  void nextPage() {
    if (currentPage < totalPages - 1) {
      setState(() {
        currentPage++;
      });
    } else {
      goToLogin();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  void goToLogin() {
    Navigator.pushReplacementNamed(context, AppRouter.login);
  }

  Widget get currentBody {
    switch (currentPage) {
      case 0:
        return const OnboardingFirstPage();
      case 1:
        return const OnboardingSecondPage();
      case 2:
        return const OnboardingThirdPage();
      default:
        return const OnboardingFirstPage();
    }
  }

  Widget get currentActions {
    switch (currentPage) {
      case 0:
        return FirstPageActions(
          onNext: nextPage,
          onSkip: goToLogin,
        );
      case 1:
        return MiddlePageActions(
          onBack: previousPage,
          onNext: nextPage,
        );
      case 2:
        return LastPageActions(
          onGetStarted: goToLogin,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTopBar() {
    if (currentPage != 1) {
      return const SizedBox(height: 24);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: goToLogin,
            child: const Text(
              'Skip',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8A8A8A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: currentBody,
                ),
              ),
            ),
            OnboardingIndicator(currentPage: currentPage),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: currentActions,
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}