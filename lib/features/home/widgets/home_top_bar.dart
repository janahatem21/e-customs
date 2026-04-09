import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HomeTopBar extends StatelessWidget {
  final VoidCallback onNotificationsTap;

  const HomeTopBar({
    super.key,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: AppColors.white,
              size: 18,
            ),
          ),
          IconButton(
            onPressed: onNotificationsTap,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.blackText,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}