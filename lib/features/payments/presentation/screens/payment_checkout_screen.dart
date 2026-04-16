import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../provider/fees_provider.dart';
import '../../domain/entities/fee_entity.dart';
import '../widgets/payment_summary_card.dart';
import '../widgets/payment_method_selector.dart';
import '../widgets/custom_credit_card.dart';
import '../widgets/digital_wallet_card.dart';
import '../widgets/payment_form_field.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';

class PaymentCheckoutScreen extends StatelessWidget {
  const PaymentCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make Payment"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // Summary Card
            Selector<FeesProvider, (String, List<FeeEntity>, double)>(
              selector: (_, p) => (p.shipmentId, p.breakdown, p.totalAmount),
              builder: (context, data, _) {
                return PaymentSummaryCard(
                  declarationId: data.$1,
                  fees: data.$2,
                  totalAmount: data.$3,
                );
              },
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 32),
            Text(
              "Select Payment Method",
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
            const SizedBox(height: 16),

            Selector<FeesProvider, int>(
              selector: (_, p) => p.selectedPaymentMethod,
              builder: (context, index, _) {
                return PaymentMethodSelector(
                  selectedIndex: index,
                  onSelected:
                      (val) =>
                          context.read<FeesProvider>().setPaymentMethod(val),
                );
              },
            ).animate().fadeIn(duration: 400.ms, delay: 150.ms),

            const SizedBox(height: 32),

            // Visual Card
            Selector<FeesProvider, (int, String, String, String)>(
              selector:
                  (_, p) => (
                    p.selectedPaymentMethod,
                    p.cardHolderName,
                    p.cardNumber,
                    p.expiryDate,
                  ),
              builder: (context, data, _) {
                final method = data.$1;
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
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
                  child:
                      method == 0
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

            // Form Fields
            Selector<FeesProvider, int>(
              selector: (_, p) => p.selectedPaymentMethod,
              builder: (context, method, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child:
                      method == 0
                          ? _buildCreditCardForm(context)
                          : _buildDigitalWalletForm(context),
                );
              },
            ),

            const SizedBox(height: 24),

            // Security Notice
            Container(
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
                            color: AppColors.securityGreenDark.withValues(
                              alpha: 0.7,
                            ),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms, delay: 450.ms),

            const SizedBox(height: 40),

            // Confirm Button
            Selector<FeesProvider, double>(
                  selector: (_, p) => p.totalAmount,
                  builder: (context, total, _) {
                    return AppButton(
                      text: "Confirm & Pay €${total.toStringAsFixed(2)}",
                      leadingIcon: const Icon(
                        Icons.lock_outline_rounded,
                        size: 18,
                      ),
                      onPressed: () {
                        // Process Payment
                      },
                    );
                  },
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 550.ms)
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),

            const SizedBox(height: 24),
            Center(
              child: Text(
                "LICENSED BY FEDERAL CUSTOMS AUTHORITY",
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  color: AppColors.subtitleColor.withValues(alpha: 0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 650.ms),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCardForm(BuildContext context) {
    final provider = context.read<FeesProvider>();
    return Column(
      key: const ValueKey("cc_form"),
      children: [
        PaymentFormField(
          label: "Cardholder Name",
          hint: "Johnathan Doe",
          value: provider.cardHolderName,
          onChanged: (val) => provider.updateCardHolderName(val),
        ),
        const SizedBox(height: 20),
        PaymentFormField(
          label: "Card Number",
          hint: "0000 0000 0000 0000",
          suffixIcon: Icons.credit_card,
          keyboardType: TextInputType.number,
          value: provider.cardNumber,
          onChanged: (val) => provider.updateCardNumber(val),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: PaymentFormField(
                label: "Expiry Date",
                hint: "MM/YY",
                keyboardType: TextInputType.datetime,
                value: provider.expiryDate,
                onChanged: (val) => provider.updateExpiryDate(val),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: PaymentFormField(
                label: "CVV",
                hint: "123",
                keyboardType: TextInputType.number,
                value: provider.cvv,
                onChanged: (val) => provider.updateCvv(val),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildDigitalWalletForm(BuildContext context) {
    return Column(
      key: const ValueKey("dw_form"),
      children: [
        PaymentFormField(
          label: "Wallet ID / Phone Number",
          hint: "+971 •• ••• ••••",
          suffixIcon: Icons.phone_android_rounded,
          keyboardType: TextInputType.phone,
          value: "",
          onChanged: (val) {},
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.subtitleColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "A verification code will be sent to your registered mobile number.",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.subtitleColor.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms);
  }
}
