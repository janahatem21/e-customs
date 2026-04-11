import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/shared_preferences_service.dart';
import '../models/onboarding_model.dart';

class OnboardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;
  int get totalPages => onboardingItems.length;
  bool get isLastPage => _currentPage == totalPages - 1;
  bool get isFirstPage => _currentPage == 0;

  final List<OnboardingModel> onboardingItems = const [
    OnboardingModel(
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDesc1,
      image: AppAssets.onboarding1,
      tag: AppStrings.digitalFirst,
      statusLabel: AppStrings.systemStatus,
      statusValue: AppStrings.globalReady,
    ),
    OnboardingModel(
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingDesc2,
      image: AppAssets.onboarding2,
      tag: AppStrings.verified,
      statusLabel: AppStrings.securityLevel,
      statusValue: AppStrings.strong,
    ),
    OnboardingModel(
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingDesc3,
      image: AppAssets.onboarding3,
      tag: AppStrings.governmentVerified,
      statusLabel: AppStrings.systemStatus,
      statusValue: AppStrings.secureEncryption,
    ),
  ];

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage(BuildContext context, String nextRoute) {
    if (_currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding(context, nextRoute);
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip(BuildContext context, String nextRoute) {
    _completeOnboarding(context, nextRoute);
  }

  void _completeOnboarding(BuildContext context, String nextRoute) {
    SharedPreferencesService.saveData(
      key: AppConstants.onBoardingKey,
      value: true,
    );
    Navigator.pushReplacementNamed(context, nextRoute);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
