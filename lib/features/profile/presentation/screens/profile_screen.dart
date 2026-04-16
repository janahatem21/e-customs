import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../provider/profile_provider.dart';
import '../widgets/profile_header.dart';
import '../widgets/setting_item.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Use Selector to rebuild only when basic profile info changes
            Selector<ProfileProvider, (String, String, String, bool)>(
              selector:
                  (_, p) => (
                    p.userName,
                    p.userEmail,
                    p.avatarUrl,
                    p.isVerified,
                  ),
              builder: (context, data, _) {
                return ProfileHeader(
                  name: data.$1,
                  email: data.$2,
                  avatarUrl: data.$3,
                  isVerified: data.$4,
                  onEdit: () {},
                );
              },
            ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 40),

            _buildSection(
                  context,
                  title: "ACCOUNT SETTINGS",
                  items: [
                    SettingItem(
                      icon: IconsaxPlusLinear.personalcard,
                      title: "Personal Information",
                      subtitle: "Update your name, contact, and address",
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: IconsaxPlusLinear.document_text_1,
                      title: "My Declarations",
                      subtitle: "View your customs filing history",
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: IconsaxPlusLinear.card,
                      title: "Payment Methods",
                      subtitle: "Manage cards and digital wallets",
                      onTap: () {},
                    ),
                  ],
                )
                .animate()
                .fadeIn(duration: 350.ms, delay: 100.ms)
                .slideY(begin: 0.05, end: 0),

            const SizedBox(height: 24),

            _buildSection(
                  context,
                  title: "SECURITY & PRIVACY",
                  items: [
                    SettingItem(
                      icon: IconsaxPlusLinear.lock_1,
                      title: "Password & PIN",
                      subtitle: "Change your security credentials",
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: IconsaxPlusLinear.shield_search,
                      title: "Two-Factor Auth",
                      subtitle: "Secure your account login",
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: IconsaxPlusLinear.setting_2,
                      title: "Preferences",
                      subtitle: "Language, Currency, and Themes",
                      onTap: () {},
                    ),
                  ],
                )
                .animate()
                .fadeIn(duration: 350.ms, delay: 150.ms)
                .slideY(begin: 0.05, end: 0),

            const SizedBox(height: 24),

            _buildSection(
                  context,
                  title: "SUPPORT & INFO",
                  items: [
                    SettingItem(
                      icon: IconsaxPlusLinear.info_circle,
                      title: "Help Center",
                      subtitle: "FAQs and contact support",
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: IconsaxPlusLinear.note_2,
                      title: "Terms of Service",
                      subtitle: "Legal and compliance documents",
                      onTap: () {},
                    ),
                  ],
                )
                .animate()
                .fadeIn(duration: 350.ms, delay: 200.ms)
                .slideY(begin: 0.05, end: 0),

            const SizedBox(height: 24),

            SettingItem(
                  icon: IconsaxPlusLinear.logout,
                  title: "Log Out",
                  subtitle: "Safely exit your account session",
                  isDestructive: true,
                  onTap: () => context.read<ProfileProvider>().logout(context),
                )
                .animate()
                .fadeIn(duration: 350.ms, delay: 250.ms)
                .slideY(begin: 0.05, end: 0),

            const SizedBox(height: 32),
            Text(
              "E-CUSTOMS V2.4.0 (BUILD 892)",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                color: AppColors.subtitleColor.withValues(alpha: 0.5),
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.subtitleColor,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...items,
      ],
    );
  }
}
