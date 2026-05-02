import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/app_card.dart';
import '../provider/add_item_provider.dart';
import 'add_item_summary_row.dart';

class AddItemStep3 extends StatelessWidget {
  const AddItemStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ).animate().fadeIn().slideY(begin: 0.1, end: 0),
          const SizedBox(height: 8),
          const Text(
            'Please check the information before adding the item.',
            style: TextStyle(color: AppColors.greyText, fontSize: 14),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          Consumer<AddItemProvider>(
            builder: (context, provider, child) {
              return AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    AddItemSummaryRow(
                      label: 'Product Name',
                      value: provider.nameController.text.isEmpty ? 'Not entered' : provider.nameController.text,
                    ),
                    AddItemSummaryRow(
                      label: 'Category',
                      value: provider.selectedCategory ?? 'Not selected',
                    ),
                    AddItemSummaryRow(
                      label: 'Price',
                      value: '${provider.priceController.text.isEmpty ? '0.00' : provider.priceController.text} ${provider.selectedCurrency}',
                    ),
                    AddItemSummaryRow(
                      label: 'Quantity',
                      value: provider.quantity.toString(),
                      showDivider: false,
                    ),
                  ],
                ),
              );
            },
          )
          .animate()
          .fadeIn(delay: 200.ms)
          .scale(begin: const Offset(0.95, 0.95)),
        ],
      ),
    );
  }
}
