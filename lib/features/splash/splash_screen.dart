import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progress = 0;
  Timer? progressTimer;

  @override
  void initState() {
    super.initState();

    progressTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (progress >= 1) {
          progress = 1;
          timer.cancel();
        } else {
          progress += 0.02;
        }
      });
    });

    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRouter.onboarding);
    });
  }

  @override
  void dispose() {
    progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.gradientTop,
                  AppColors.gradientMid,
                  AppColors.gradientLight,
                  AppColors.gradientBottom,
                ],
                stops: [0.0, 0.38, 0.72, 1.0],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Colors.white.withOpacity(0.65),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.18),
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppAssets.logo,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                const Text(
                  AppStrings.appName,
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2.2,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appNameColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.28),
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.018),
                const Text(
                  AppStrings.splashLoading,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.subtitleColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                  child: Container(
                    width: double.infinity,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.gradientMid,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: screenWidth * 0.7 * progress,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.verified_user_outlined,
                        size: 12,
                        color: AppColors.footerColor,
                      ),
                      SizedBox(width: 6),
                      Text(
                        AppStrings.splashFooter,
                        style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 0.4,
                          color: AppColors.footerColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}