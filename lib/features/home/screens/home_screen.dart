import 'package:e_customs/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/home_greeting_section.dart';
import '../widgets/quick_actions_section.dart';

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
            _buildStatsSection()
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

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Declarations Overview',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'This Month',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('12', 'Total', Colors.white),
                _buildStatDivider(),
                _buildStatItem('08', 'Approved', AppColors.success),
                _buildStatDivider(),
                _buildStatItem('04', 'Pending', AppColors.warning),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(height: 30, width: 1, color: Colors.white12);
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white60,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
