import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/core/widgets/app_button.dart';
import 'package:e_customs/core/widgets/app_card.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            IconsaxPlusLinear.arrow_left,
            color: AppColors.blackText,
          ),
        ),
        title: const Text(
          'Your QR Code',
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
          children: [
            // 1. QR Code Section
            _buildQRSection(),
            
            const SizedBox(height: 32),
            
            // 2. Status / Validity Section
            _buildStatusSection(),
            
            const SizedBox(height: 32),
            
            // 3. Information Section
            _buildInformationSection(),
            
            const SizedBox(height: 40),
            
            // 4. Trust Indicator
            _buildTrustIndicator(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildActions(context),
    );
  }

  Widget _buildQRSection() {
    return AppCard(
      padding: const EdgeInsets.all(32),
      color: Colors.white,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.lightGrey.withOpacity(0.5)),
          ),
          child: Image.network(
            'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=CUSTOMS-TXN-982345012',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            },
          ),
        ),
      ),
    )
    .animate()
    .scale(
      duration: 600.ms,
      curve: Curves.easeOutBack,
      begin: const Offset(0.9, 0.9),
    )
    .fadeIn(duration: 400.ms);
  }

  Widget _buildStatusSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.securityGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(IconsaxPlusBold.tick_circle, color: AppColors.securityGreen, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Paid & Verified',
                style: TextStyle(
                  color: AppColors.securityGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Valid for scanning at customs',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.greyText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildInformationSection() {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildInfoRow('Account Holder', 'Ahmed Mohamed'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColors.lightGrey, height: 1),
          ),
          _buildInfoRow('Total Amount', '\$660.50'),
          const SizedBox(height: 12),
          _buildInfoRow('Items Declared', '4 Items'),
          const SizedBox(height: 12),
          _buildInfoRow('Transaction ID', 'TXN-982345012'),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.greyText,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.blackText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTrustIndicator() {
    return Column(
      children: [
        const Icon(IconsaxPlusBold.shield_tick, color: AppColors.securityGreen, size: 32),
        const SizedBox(height: 12),
        const Text(
          'OFFICIAL DOCUMENT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: AppColors.blackText,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Show this QR at customs checkpoint for verification',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.greyText,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              text: 'Download',
              onPressed: () {},
              variant: AppButtonVariant.outline,
              leadingIcon: const Icon(IconsaxPlusLinear.document_download, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              text: 'Share',
              onPressed: () {},
              leadingIcon: const Icon(IconsaxPlusLinear.export, size: 20),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms);
  }
}
