import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../provider/add_item_provider.dart';

class AddItemCategoryDropdown extends StatelessWidget {
  const AddItemCategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Category',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.blackText,
            ),
          ),
        ),
        Selector<AddItemProvider, (String?, List<String>)>(
          selector:
              (_, provider) => (provider.selectedCategory, provider.categories),
          builder: (context, data, child) {
            final selectedCategory = data.$1;
            final categories = data.$2;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.lightGrey.withValues(alpha: 0.5),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text(
                    'Select category',
                    style: TextStyle(color: AppColors.greyText, fontSize: 14),
                  ),
                  isExpanded: true,
                  icon: const Icon(IconsaxPlusLinear.arrow_down_1, size: 18),
                  items:
                      categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.blackText,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    context.read<AddItemProvider>().setCategory(newValue);
                  },
                ),
              ),
            );
          },
        ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1, end: 0),
      ],
    );
  }
}
