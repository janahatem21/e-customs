import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_input.dart';
import '../provider/payment_provider.dart';

class PaymentWalletForm extends StatelessWidget {
  const PaymentWalletForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, provider, child) {
        return Column(
          key: const ValueKey('wallet_form'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppInput(
              label: 'Phone Number',
              hintText: '+971 50 123 4567',
              keyboardType: TextInputType.phone,
              onChanged: provider.updatePhoneNumber,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Required';
                if (value.length < 9) return 'Invalid phone number';
                return null;
              },
              prefixIcon: const Icon(
                IconsaxPlusLinear.mobile,
                size: 20,
                color: AppColors.greyText,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'We will send a verification code to this number.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.greyText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}
