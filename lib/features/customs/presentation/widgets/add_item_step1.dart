import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/app_input.dart';
import '../provider/add_item_provider.dart';
import 'add_item_category_dropdown.dart';

class AddItemStep1 extends StatelessWidget {
  const AddItemStep1({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddItemProvider>();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell us about the product',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ).animate().fadeIn().slideY(begin: 0.1, end: 0),
          const SizedBox(height: 8),
          const Text(
            'Enter the basic details of the item you want to add to your declaration.',
            style: TextStyle(color: AppColors.greyText, fontSize: 14),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          AppInput(
            label: 'Product Name',
            hintText: 'e.g. iPhone 15 Pro',
            controller: provider.nameController,
            prefixIcon: const Icon(IconsaxPlusLinear.box, size: 20),
          ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1, end: 0),
          const SizedBox(height: 20),
          const AddItemCategoryDropdown(),
        ],
      ),
    );
  }
}
