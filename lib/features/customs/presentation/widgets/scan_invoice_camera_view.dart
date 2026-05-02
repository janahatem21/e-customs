import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../../core/constants/app_colors.dart';
import '../provider/scan_invoice_provider.dart';
import 'scan_invoice_step_indicator.dart';
import 'scan_invoice_bottom_actions.dart';
import 'scan_invoice_camera_placeholder.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (provider.selectedImage != null)
                  AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Image.file(
                        provider.selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  const ScanInvoiceCameraPlaceholder(),
                const SizedBox(height: 24),
                Text(
                  provider.selectedImage != null
                      ? 'Ready to scan this invoice'
                      : 'Pick or capture an invoice',
                  style: const TextStyle(
                    color: AppColors.greyText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(delay: 200.ms),
              ],
            ),
          ),
        ),
        if (provider.selectedImage != null)
          ScanInvoiceBottomActions(
            primaryText: 'Scan Invoice',
            onPrimary: provider.scanInvoice,
            primaryIcon: const Icon(
              IconsaxPlusLinear.document_filter,
              size: 20,
            ),
            secondaryText: 'Retake',
            onSecondary: provider.reset,
          )
        else
          ScanInvoiceBottomActions(
            primaryText: 'Camera',
            onPrimary: provider.pickFromCamera,
            primaryIcon: const Icon(IconsaxPlusLinear.camera, size: 20),
            secondaryText: 'Gallery',
            onSecondary: provider.pickFromGallery,
          ),
      ],
    );
  }
}
