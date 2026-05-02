import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/app_input.dart';
import '../provider/add_item_provider.dart';
import 'add_item_currency_dropdown.dart';
import 'add_item_quantity_stepper.dart';

class AddItemStep2 extends StatelessWidget {
  const AddItemStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddItemProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price & Quantity',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ).animate().fadeIn().slideY(begin: 0.1, end: 0),
          const SizedBox(height: 8),
          const Text(
            'Specify the value and the amount of items.',
            style: TextStyle(color: AppColors.greyText, fontSize: 14),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: AppInput(
                  label: 'Price',
                  hintText: '0.00',
                  controller: provider.priceController,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(IconsaxPlusLinear.money_3, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: AddItemCurrencyDropdown(),
              ),
            ],
          ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          const Text(
            'Quantity',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.blackText,
            ),
          ),
          const SizedBox(height: 12),
          const AddItemQuantityStepper(),
        ],
      ),
    );
  }
}
