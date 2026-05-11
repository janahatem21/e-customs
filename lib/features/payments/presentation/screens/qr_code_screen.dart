import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../provider/payment_provider.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        title: const Text('Declaration QR Code'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed:
                () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.layout,
                  (route) => false,
                ),
            icon: const Icon(IconsaxPlusLinear.close_circle),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSuccessHeader(),
            const SizedBox(height: 32),
            _buildQRSection(context),
            const SizedBox(height: 32),
            _buildPaymentSummary(context),
            const SizedBox(height: 40),
            AppButton(
              text: 'Done',
              onPressed:
                  () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouter.layout,
                    (route) => false,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.securityGreen.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            IconsaxPlusBold.shield_tick,
            color: AppColors.securityGreen,
            size: 48,
          ),
        ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
        const SizedBox(height: 16),
        const Text(
          'Payment Successful',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.blackText,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 8),
        const Text(
          'Your declaration has been processed and paid.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: AppColors.greyText),
        ).animate().fadeIn(delay: 300.ms),
      ],
    );
  }

  Widget _buildQRSection(BuildContext context) {
    final paymentProvider = context.read<PaymentProvider>();
    final qrData = paymentProvider.paymentResult?.qrData ?? "NO_DATA";

    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'Official QR Receipt',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: AppColors.primary,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: AppColors.primary,
              ),
            ),
          ).animate().scale(delay: 400.ms, duration: 500.ms),
          const SizedBox(height: 16),
          Text(
            'Declaration ID: ${paymentProvider.paymentResult?.declarationId ?? "N/A"}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.greyText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(BuildContext context) {
    final paymentProvider = context.read<PaymentProvider>();

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildRow('Status', 'PAID', isStatus: true),
          const Divider(height: 24),
          _buildRow(
            'Total Paid',
            '${paymentProvider.currency} ${paymentProvider.totalAmount.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _buildRow('Payment Method', 'Visa •••• 4242'),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildRow(String label, String value, {bool isStatus = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.greyText,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.securityGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.securityGreen,
              ),
            ),
          )
        else
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ),
      ],
    );
  }
}
