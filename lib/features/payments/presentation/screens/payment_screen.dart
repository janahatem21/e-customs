import 'package:e_customs/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/core/widgets/app_button.dart';
import 'package:e_customs/core/widgets/app_card.dart';
import 'package:e_customs/core/widgets/app_input.dart';

enum PaymentMethod { card, wallet }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.card;
  bool _isProcessing = false;

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
          'Payment',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 32),
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.blackText,
              ),
            ),
            const SizedBox(height: 16),
            _buildPaymentMethods(),
            const SizedBox(height: 32),
            AnimatedSwitcher(duration: 300.ms, child: _buildDynamicDetails()),
            const SizedBox(height: 40),
            _buildSecurityIndicator(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: _buildCTA(),
    );
  }

  Widget _buildSummaryCard() {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackText,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '\$660.50',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                      letterSpacing: -1,
                    ),
                  ).animate().scale(
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                    begin: const Offset(0.9, 0.9),
                  ),
                  Text(
                    'All taxes included',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: AppColors.lightGrey, height: 1),
          ),
          _buildSummaryRow('Customs Fees', '\$450.00'),
          const SizedBox(height: 12),
          _buildSummaryRow('VAT (15%)', '\$210.50'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
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
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.blackText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      children: [
        _buildMethodItem(
          method: PaymentMethod.card,
          icon: IconsaxPlusLinear.card,
          title: 'Credit / Debit Card',
          subtitle: 'Visa, Mastercard, Amex',
        ),
        const SizedBox(height: 12),
        _buildMethodItem(
          method: PaymentMethod.wallet,
          icon: IconsaxPlusLinear.mobile,
          title: 'Mobile Wallet',
          subtitle: 'Apple Pay, Google Pay',
        ),
      ],
    );
  }

  Widget _buildMethodItem({
    required PaymentMethod method,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedMethod == method;

    return AppCard(
      onTap: () => setState(() => _selectedMethod = method),
      padding: const EdgeInsets.all(16),
      color: isSelected ? AppColors.primary.withOpacity(0.02) : AppColors.white,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? AppColors.primary
                      : AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.white : AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: AppColors.blackText,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.greyText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.lightGrey,
                width: isSelected ? 6 : 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicDetails() {
    return switch (_selectedMethod) {
      PaymentMethod.card => _buildCardForm(),
      PaymentMethod.wallet => _buildWalletForm(),
    };
  }

  Widget _buildCardForm() {
    return Column(
      key: const ValueKey('card_form'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppInput(
          label: 'Card Holder Name',
          hintText: 'e.g. Ahmed Mohamed',
          prefixIcon: Icon(
            IconsaxPlusLinear.user,
            size: 20,
            color: AppColors.greyText,
          ),
        ),
        const SizedBox(height: 20),
        const AppInput(
          label: 'Card Number',
          hintText: '0000 0000 0000 0000',
          keyboardType: TextInputType.number,
          prefixIcon: Icon(
            IconsaxPlusLinear.card,
            size: 20,
            color: AppColors.greyText,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Expanded(
              child: AppInput(
                label: 'Expiry Date',
                hintText: 'MM/YY',
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: AppInput(
                label: 'CVV',
                hintText: '123',
                obscureText: true,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWalletForm() {
    return Column(
      key: const ValueKey('wallet_form'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppInput(
          label: 'Phone Number',
          hintText: '+971 50 123 4567',
          keyboardType: TextInputType.phone,
          prefixIcon: Icon(
            IconsaxPlusLinear.mobile,
            size: 20,
            color: AppColors.greyText,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'We will send a verification code to this number.',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.greyText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          IconsaxPlusBold.lock,
          color: AppColors.securityGreen,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          'Secure 256-bit SSL Encrypted Payment',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.securityGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildCTA() {
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
      child: AppButton(
        text: _isProcessing ? 'Processing...' : 'Pay Now',
        isLoading: _isProcessing,
        onPressed: () {
          setState(() => _isProcessing = true);
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() => _isProcessing = false);
              Navigator.pushNamed(context, AppRouter.paymentSuccess);
            }
          });
        },
        leadingIcon: const Icon(IconsaxPlusBold.shield_tick, size: 20),
      ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms),
    );
  }
}
