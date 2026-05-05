import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_input.dart';
import '../provider/payment_provider.dart';

class PaymentCardForm extends StatelessWidget {
  const PaymentCardForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, provider, child) {
        return Column(
          key: const ValueKey('card_form'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppInput(
              label: 'Card Holder Name',
              hintText: 'e.g. Ahmed Mohamed',
              onChanged: provider.updateCardHolderName,
              prefixIcon: const Icon(
                IconsaxPlusLinear.user,
                size: 20,
                color: AppColors.greyText,
              ),
            ),
            const SizedBox(height: 20),
            AppInput(
              label: 'Card Number',
              hintText: '0000 0000 0000 0000',
              keyboardType: TextInputType.number,
              onChanged: provider.updateCardNumber,
              prefixIcon: const Icon(
                IconsaxPlusLinear.card,
                size: 20,
                color: AppColors.greyText,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppInput(
                    label: 'Expiry Date',
                    hintText: 'MM/YY',
                    keyboardType: TextInputType.number,
                    onChanged: provider.updateExpiryDate,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppInput(
                    label: 'CVV',
                    hintText: '123',
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    onChanged: provider.updateCvv,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
