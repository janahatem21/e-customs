import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HomeGreetingSection extends StatelessWidget {
  const HomeGreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lightGrey.withOpacity(0.5),
            ),
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Ahmed 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.blackText,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Your shipment from Dubai is in transit.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}