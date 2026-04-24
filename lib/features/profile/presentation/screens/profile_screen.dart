import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/core/widgets/app_card.dart';
import 'package:e_customs/core/routes/app_router.dart';
import '../provider/profile_provider.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.blackText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.settings),
            icon: const Icon(IconsaxPlusLinear.setting_2, color: AppColors.blackText),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            // 1. User Info Section (Header)
            Consumer<ProfileProvider>(
              builder: (context, provider, _) {
                return ProfileHeader(
                  name: provider.userName,
                  email: provider.userEmail,
                  avatarUrl: provider.avatarUrl,
                  isVerified: provider.isVerified,
                  onEdit: () => Navigator.pushNamed(context, AppRouter.editProfile),
                );
              },
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
            
            const SizedBox(height: 32),
            
            // 2. Personal Information Section
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.blackText,
              ),
            ).animate().fadeIn(delay: 200.ms),
            
            const SizedBox(height: 16),
            
            _buildInfoList().animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
            
            const SizedBox(height: 32),
          ],
        ),
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
              color: AppColors.primary.withOpacity(0.05),
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
