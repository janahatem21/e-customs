import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/core/widgets/app_button.dart';
import 'package:e_customs/features/profile/presentation/provider/profile_provider.dart';
import 'package:e_customs/features/profile/presentation/widgets/setting_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(IconsaxPlusLinear.arrow_left, color: AppColors.blackText),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.blackText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Preferences'),
            const SizedBox(height: 16),
            SettingItem(
              icon: IconsaxPlusLinear.global,
              title: 'Language',
              subtitle: 'English (US)',
              onTap: () {
                // Show language selector modal
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Support'),
            const SizedBox(height: 16),
            SettingItem(
              icon: IconsaxPlusLinear.info_circle,
              title: 'Help Center',
              subtitle: 'FAQs and Support',
              onTap: () {
                // Navigate to help center
              },
            ),
            SettingItem(
              icon: IconsaxPlusLinear.shield_tick,
              title: 'Privacy Policy',
              subtitle: 'Terms and Conditions',
              onTap: () {
                // Navigate to privacy policy
              },
            ),
            const SizedBox(height: 32),
            SettingItem(
              icon: IconsaxPlusLinear.logout,
              title: 'Logout',
              subtitle: 'Sign out of your account',
              isDestructive: true,
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.greyText,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.greyText)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProfileProvider>().logout(context);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
