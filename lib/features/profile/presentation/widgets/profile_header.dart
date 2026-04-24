import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String avatarUrl;
  final bool isVerified;
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.isVerified,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(avatarUrl),
                backgroundColor: AppColors.lightGrey,
              ),
            ),
            if (isVerified)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 22,
            color: AppColors.blackText,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (isVerified) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "VERIFIED",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 8,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 240, // Increased width slightly for a more prominent button
              child: AppButton(
                text: "Edit Profile",
                onPressed: onEdit,
                variant: AppButtonVariant.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
