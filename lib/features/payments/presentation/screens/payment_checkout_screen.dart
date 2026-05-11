import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../provider/payment_provider.dart';
import '../widgets/payment_summary_card.dart';
import '../widgets/payment_method_selector.dart';
import '../widgets/custom_credit_card.dart';
import '../widgets/digital_wallet_card.dart';
import '../widgets/payment_card_form.dart';
import '../widgets/payment_wallet_form.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/providers/user_provider.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../customs/presentation/provider/declaration_provider.dart';

class PaymentCheckoutScreen extends StatelessWidget {
  const PaymentCheckoutScreen({super.key});

  Future<void> _handlePayment(BuildContext context) async {
    final paymentProvider = context.read<PaymentProvider>();
    final userProvider = context.read<UserProvider>();
    final declarationProvider = context.read<DeclarationProvider>();

    final userId = userProvider.user?.id;
    final declarationId = declarationProvider.currentDeclarationId;

    if (userId == null || declarationId == null) {
      AppDialogs.showErrorSnackBar(context, 'Missing user or declaration data');
      return;
    }

    final success = await paymentProvider.pay(
      userId: userId,
      declarationId: declarationId,
    );

    if (success) {
      if (context.mounted) {
        Navigator.pushNamed(context, AppRouter.paymentSuccess);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make Payment"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // Summary Card
            const PaymentSummaryCard()
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1, end: 0),

            const SizedBox(height: 32),
            Text(
              "Select Payment Method",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
            const SizedBox(height: 16),

            const PaymentMethodSelector()
                .animate()
                .fadeIn(duration: 400.ms, delay: 150.ms),

            const SizedBox(height: 32),

            // Visual Card Representation
            Selector<PaymentProvider, (AppPaymentMethod, String, String, String)>(
              selector: (_, p) => (
                p.selectedMethod,
                p.cardHolderName,
                p.cardNumber,
                p.expiryDate,
              ),
              builder: (context, data, _) {
                final method = data.$1;
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: method == AppPaymentMethod.card
                      ? CustomCreditCard(
                          key: const ValueKey("credit_card"),
                          cardHolder: data.$2,
                          cardNumber: data.$3,
                          expiry: data.$4,
                        )
                      : const DigitalWalletCard(
                          key: ValueKey("digital_wallet"),
                        ),
                );
              },
            ).animate().fadeIn(duration: 500.ms, delay: 250.ms),

            const SizedBox(height: 32),

            // Form Fields Section
            Selector<PaymentProvider, AppPaymentMethod>(
              selector: (_, p) => p.selectedMethod,
              builder: (context, method, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: method == AppPaymentMethod.card
                      ? const PaymentCardForm()
                      : const PaymentWalletForm(),
                );
              },
            ),

            const SizedBox(height: 24),

            // Security Notice
            _buildSecurityNotice().animate().fadeIn(duration: 400.ms, delay: 450.ms),

            const SizedBox(height: 40),

            // Confirm Button
            Consumer<PaymentProvider>(
              builder: (context, provider, _) {
                return AppButton(
                  text: provider.isLoading
                      ? "Processing..."
                      : "Confirm & Pay ${provider.currency} ${provider.totalAmount.toStringAsFixed(2)}",
                  isLoading: provider.isLoading,
                  leadingIcon: const Icon(
                    Icons.lock_outline_rounded,
                    size: 18,
                  ),
                  onPressed: () => _handlePayment(context),
                );
              },
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 550.ms)
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),

            const SizedBox(height: 24),
            _buildFooter(context),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.securityGreenLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.securityGreen.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_user_rounded,
            color: AppColors.securityGreen,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bank-Grade Encryption",
                  style: TextStyle(
                    color: AppColors.securityGreenDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Your payment information is encrypted and processed via a secure SSL connection.",
                  style: TextStyle(
                    color: AppColors.securityGreenDark.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Text(
        "LICENSED BY FEDERAL CUSTOMS AUTHORITY",
        style: TextStyle(
          fontSize: 10,
          letterSpacing: 1,
          color: AppColors.subtitleColor.withValues(alpha: 0.5),
          fontWeight: FontWeight.bold,
        ),
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 650.ms);
  }
}
