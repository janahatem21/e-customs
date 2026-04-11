import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:e_customs/core/constants/app_colors.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              IconsaxPlusLinear.notification_status,
              size: 64,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Notifications Yet',
            style: theme.textTheme.headlineLarge?.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            'We will notify you when something\nimportant happens.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.subtitleColor),
          ),
        ],
      ),
    );
  }
}
