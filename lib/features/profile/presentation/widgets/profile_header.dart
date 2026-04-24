import 'package:e_customs/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final bool isVerified;
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.isVerified,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Image.asset(AppAssets.logo, height: 100, width: 100),
        const SizedBox(height: 24),
        // 2. Name
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 24,
                color: AppColors.blackText,
              ),
            ),
            if (isVerified) ...[
              const SizedBox(width: 8),
              const Icon(
                Icons.verified_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        // 3. Email
        Text(
          email,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.greyText),
        ),
        const SizedBox(height: 16),
        // 4. Edit Button (Simple Text Button with Icon)
        AppButton(
          text: "Edit Profile",
          onPressed: onEdit,
          variant: AppButtonVariant.tonal,
          fullWidth: false,
          leadingIcon: const Icon(IconsaxPlusLinear.edit, size: 18),
        ),
      ],
    );
  }
}
