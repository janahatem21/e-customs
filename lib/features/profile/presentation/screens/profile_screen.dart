import 'package:e_customs/core/utils/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/core/widgets/app_card.dart';
import 'package:e_customs/core/routes/app_router.dart';
import '../provider/profile_provider.dart';
import '../widgets/profile_header.dart';
import 'package:e_customs/features/profile/presentation/widgets/setting_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. User Info Section (Header)
            Center(
              child: Consumer<ProfileProvider>(
                builder: (context, provider, _) {
                  return ProfileHeader(
                    name: provider.userName,
                    email: provider.userEmail,
                    isVerified: provider.isVerified,
                    onEdit:
                        () =>
                            Navigator.pushNamed(context, AppRouter.editProfile),
                  );
                },
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 32),

            // 2. Personal Information Section
            _buildSectionTitle('Personal Information'),
            const SizedBox(height: 16),
            _buildInfoList()
                .animate()
                .fadeIn(delay: 200.ms)
                .slideY(begin: 0.1, end: 0),

            const SizedBox(height: 32),

            // 3. Support & Legal Section
            _buildSectionTitle('Support & Legal'),
            const SizedBox(height: 16),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  SettingItem(
                    icon: IconsaxPlusLinear.info_circle,
                    title: 'Help Center',
                    subtitle: 'FAQs and Support',
                    onTap: () {},
                    flat: true,
                  ),
                  const Divider(
                    height: 1,
                    indent: 64,
                    endIndent: 16,
                    color: AppColors.lightGrey,
                  ),
                  SettingItem(
                    icon: IconsaxPlusLinear.shield_tick,
                    title: 'Privacy Policy',
                    subtitle: 'Terms and Conditions',
                    onTap: () {},
                    flat: true,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 32),

            // 4. Logout Section
            _buildSectionTitle('Account'),
            const SizedBox(height: 16),
            SettingItem(
              icon: IconsaxPlusLinear.logout_1,
              title: 'Logout',
              subtitle: 'Sign out of your account securely',
              isDestructive: true,
              onTap:
                  () => AppDialogs.showLogoutDialog(
                    context,
                    onLogout:
                        () => context.read<ProfileProvider>().logout(context),
                  ),
            ).animate().fadeIn(delay: 500.ms),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.blackText,
      ),
    );
  }

  Widget _buildInfoList() {
    return Consumer<ProfileProvider>(
      builder: (context, provider, _) {
        return Column(
          children: [
            _buildInfoCard(
              label: 'Full Name',
              value: provider.userName,
              icon: IconsaxPlusLinear.user,
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              label: 'Passport Number / National ID',
              value: 'P123456789', // Mock value
              icon: IconsaxPlusLinear.card,
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              label: 'Email Address',
              value: provider.userEmail,
              icon: IconsaxPlusLinear.sms,
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackText,
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
