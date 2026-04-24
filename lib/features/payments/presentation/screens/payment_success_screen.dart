import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/core/routes/app_router.dart';
import 'package:e_customs/core/widgets/app_button.dart';
import 'package:e_customs/core/widgets/app_card.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // 1. Success Visual
              _buildSuccessIcon(),
              
              const SizedBox(height: 32),
              
              // 2. Message Section
              _buildMessageSection(),
              
              const Spacer(),
              
              // 3. Summary Card
              _buildSummaryCard(),
              
              const Spacer(flex: 2),
              
              // 4. Actions Section
              _buildActions(context),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.securityGreen.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: AppColors.securityGreen,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            IconsaxPlusBold.tick_circle,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    )
    .animate()
    .scale(
      duration: 600.ms,
      curve: Curves.easeOutBack,
    )
    .shimmer(
      delay: 800.ms,
      duration: 1500.ms,
      color: Colors.white.withOpacity(0.3),
    );
  }

  Widget _buildMessageSection() {
    return Column(
      children: [
        const Text(
          'Payment Successful',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.blackText,
            letterSpacing: -0.5,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 12),
        Text(
          'Your customs payment has been completed successfully',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: AppColors.greyText,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildSummaryRow('Paid Amount', '\$660.50', isAmount: true),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColors.lightGrey, height: 1),
          ),
          _buildSummaryRow('Date', 'April 22, 2026'),
          const SizedBox(height: 12),
          _buildSummaryRow('Transaction ID', 'TXN-982345012'),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildSummaryRow(String label, String value, {bool isAmount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.greyText,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isAmount ? 18 : 14,
            color: isAmount ? AppColors.primary : AppColors.blackText,
            fontWeight: isAmount ? FontWeight.w900 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        AppButton(
          text: 'View QR Code',
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.qrCode);
          },
          leadingIcon: const Icon(IconsaxPlusLinear.barcode, size: 20),
        ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 12),
        AppButton(
          text: 'Back to Home',
          variant: AppButtonVariant.outline,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.layout,
              (route) => false,
            );
          },
        ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2, end: 0),
      ],
    );
  }
}
