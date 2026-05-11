import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/user_provider.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../core/widgets/app_button.dart';
import '../provider/payment_provider.dart';

class PaymentActions extends StatelessWidget {
  const PaymentActions({super.key});

  Future<void> _handlePayment(BuildContext context) async {
    final paymentProvider = context.read<PaymentProvider>();

    // 1. Validate Form
    if (!(paymentProvider.formKey.currentState?.validate() ?? false)) {
      return;
    }

    final userProvider = context.read<UserProvider>();

    final userId = userProvider.user?.id;
    final declarationId = paymentProvider.declarationId;

    if (userId == null || declarationId == null) {
      AppDialogs.showErrorSnackBar(context, 'Missing user or declaration data');
      return;
    }

    // 2. Show Premium Processing Dialog
    _showProcessingOverlay(context);

    // 3. Perform Payment
    final success = await paymentProvider.pay(
      userId: userId,
      declarationId: declarationId,
    );

    // 4. Wait a bit if success to show the "Confirmed" state in dialog
    if (success) {
      await Future.delayed(const Duration(milliseconds: 1500));
    }

    // 5. Close Overlay
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (success) {
      if (context.mounted) {
        Navigator.pushNamed(
          context,
          AppRouter.qrCode,
          arguments: paymentProvider,
        );
      }
    } else {
      if (context.mounted) {
        AppDialogs.showErrorSnackBar(
          context,
          paymentProvider.errorMessage ?? 'Payment failed',
        );
      }
    }
  }

  void _showProcessingOverlay(BuildContext context) {
    final paymentProvider = context.read<PaymentProvider>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => ChangeNotifierProvider.value(
            value: paymentProvider,
            child: const _PremiumProcessingDialog(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Consumer<PaymentProvider>(
        builder: (context, provider, child) {
          return AppButton(
            text: provider.isLoading ? 'Securing...' : 'Secure Payment',
            isLoading: provider.isLoading,
            onPressed: () => _handlePayment(context),
            leadingIcon: const Icon(IconsaxPlusBold.shield_tick, size: 20),
          ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms);
        },
      ),
    );
  }
}

class _PremiumProcessingDialog extends StatefulWidget {
  const _PremiumProcessingDialog();

  @override
  State<_PremiumProcessingDialog> createState() =>
      _PremiumProcessingDialogState();
}

class _PremiumProcessingDialogState extends State<_PremiumProcessingDialog> {
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenToPayment();
    });
  }

  void _listenToPayment() {
    if (!mounted) return;
    final provider = context.read<PaymentProvider>();
    provider.addListener(_onProviderChanged);
  }

  void _onProviderChanged() {
    if (!mounted) return;
    final provider = context.read<PaymentProvider>();
    if (!provider.isLoading && provider.paymentResult != null && !_isSuccess) {
      setState(() {
        _isSuccess = true;
      });
      provider.removeListener(_onProviderChanged);
    }
  }

  @override
  void dispose() {
    try {
      context.read<PaymentProvider>().removeListener(_onProviderChanged);
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconSection(),
              const SizedBox(height: 32),
              _buildTextSection(),
              const SizedBox(height: 24),
              _buildSecurityBadge(),
            ],
          ),
        ),
      ).animate().scale(
        begin: const Offset(0.9, 0.9),
        curve: Curves.easeOutBack,
      ),
    );
  }

  Widget _buildIconSection() {
    if (_isSuccess) {
      return Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          color: AppColors.securityGreen,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          IconsaxPlusBold.tick_circle,
          color: Colors.white,
          size: 48,
        ),
      ).animate().scale(duration: 400.ms, curve: Curves.elasticOut);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 3,
          ),
        ),
        const Icon(
              IconsaxPlusBold.shield_security,
              color: AppColors.primary,
              size: 32,
            )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1200.ms, color: AppColors.securityGreen),
      ],
    );
  }

  Widget _buildTextSection() {
    return Column(
      children: [
        Text(
          _isSuccess ? 'Payment Confirmed' : 'Securing Payment',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: AppColors.blackText,
            letterSpacing: -0.5,
          ),
        ).animate(key: ValueKey('title_$_isSuccess')).fadeIn(duration: 400.ms),
        const SizedBox(height: 12),
        Text(
          _isSuccess
              ? 'Your transaction has been finalized successfully.'
              : 'Processing your transaction via encrypted bank servers...',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.greyText,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ).animate(key: ValueKey('desc_$_isSuccess')).fadeIn(duration: 400.ms),
      ],
    );
  }

  Widget _buildSecurityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            _isSuccess
                ? AppColors.securityGreen.withValues(alpha: 0.1)
                : AppColors.gradientTop,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _isSuccess ? IconsaxPlusBold.verify : IconsaxPlusBold.lock,
            size: 14,
            color: _isSuccess ? AppColors.securityGreen : AppColors.greyText,
          ),
          const SizedBox(width: 8),
          Text(
            _isSuccess ? 'TRANSACTION SUCCESSFUL' : 'AES-256 ENCRYPTED',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: _isSuccess ? AppColors.securityGreen : AppColors.greyText,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    ).animate().scale(delay: 200.ms);
  }
}
