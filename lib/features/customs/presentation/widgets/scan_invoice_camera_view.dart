import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/app_card.dart';
import '../provider/scan_invoice_provider.dart';
import 'scan_invoice_step_indicator.dart';
import 'scan_invoice_bottom_actions.dart';

class ScanInvoiceCameraView extends StatelessWidget {
  final ScanInvoiceProvider provider;

  const ScanInvoiceCameraView({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('camera'),
      children: [
        const ScanInvoiceStepIndicator(step: 1),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: AnimatedSwitcher(
              duration: 500.ms,
              child:
                  provider.selectedImage != null
                      ? _buildImagePreview()
                      : _buildSelectionView(),
            ),
          ),
        ),
        if (provider.selectedImage != null)
          ScanInvoiceBottomActions(
            primaryText: 'Start Scanning',
            onPrimary: provider.scanInvoice,
            primaryIcon: const Icon(
              IconsaxPlusLinear.document_filter,
              size: 20,
            ),
            secondaryText: 'Retake',
            onSecondary: provider.reset,
          ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Image.file(provider.selectedImage!, fit: BoxFit.cover),
          ),
        ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9)),
        const SizedBox(height: 32),
        const Text(
          'Invoice captured successfully!',
          style: TextStyle(
            color: AppColors.blackText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5, end: 0),
        const SizedBox(height: 8),
        const Text(
          'Tap the button below to extract data.',
          style: TextStyle(color: AppColors.subtitleColor, fontSize: 14),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }

  Widget _buildSelectionView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Add Your Invoice',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.blackText,
            letterSpacing: -0.5,
          ),
        ).animate().fadeIn().slideY(begin: -0.2, end: 0),
        const SizedBox(height: 8),
        const Text(
          'Choose how you want to upload your receipt',
          style: TextStyle(color: AppColors.subtitleColor, fontSize: 15),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 48),
        Row(
          children: [
            Expanded(
              child: _SelectionCard(
                title: 'Camera',
                subtitle: 'Take a photo',
                icon: IconsaxPlusBold.camera,
                color: AppColors.primary,
                onTap: provider.pickFromCamera,
              ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2, end: 0),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _SelectionCard(
                title: 'Gallery',
                subtitle: 'Upload image',
                icon: IconsaxPlusBold.gallery,
                color: AppColors.securityGreen,
                onTap: provider.pickFromGallery,
              ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.2, end: 0),
            ),
          ],
        ),
      ],
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SelectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      radius: 28,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.subtitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
