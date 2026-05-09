import 'package:e_customs/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/home_greeting_section.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/home_stats_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            const HomeGreetingSection()
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.1, end: 0, curve: Curves.easeOutQuad),
            const HomeStatsSection()
                .animate()
                .fadeIn(delay: 100.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Quick Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackText,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const QuickActionsSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class HomeServiceItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? route;
  final int? tabIndex;

  const HomeServiceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.route,
    this.tabIndex,
  });
}
