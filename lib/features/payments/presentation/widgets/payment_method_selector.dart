import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../provider/payment_provider.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _MethodItem(
          method: AppPaymentMethod.card,
          icon: IconsaxPlusLinear.card,
          title: 'Credit / Debit Card',
          subtitle: 'Visa, Mastercard, Amex',
        ),
        SizedBox(height: 12),
        _MethodItem(
          method: AppPaymentMethod.wallet,
          icon: IconsaxPlusLinear.mobile,
          title: 'Mobile Wallet',
          subtitle: 'Apple Pay, Google Pay',
        ),
      ],
    );
  }
}

class _MethodItem extends StatelessWidget {
  final AppPaymentMethod method;
  final IconData icon;
  final String title;
  final String subtitle;

  const _MethodItem({
    required this.method,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, provider, child) {
        final isSelected = provider.selectedMethod == method;

        return AppCard(
          onTap: () => provider.setPaymentMethod(method),
          padding: const EdgeInsets.all(16),
          color: isSelected ? AppColors.primary.withValues(alpha: 0.02) : AppColors.white,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.05),
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
                      style: const TextStyle(
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
      },
    );
  }
}
