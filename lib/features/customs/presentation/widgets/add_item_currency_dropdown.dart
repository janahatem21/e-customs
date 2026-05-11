import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../provider/add_item_provider.dart';

class AddItemCurrencyDropdown extends StatelessWidget {
  const AddItemCurrencyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Currency',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.blackText,
            ),
          ),
        ),
        Selector<AddItemProvider, (String, List<String>)>(
          selector:
              (_, provider) => (provider.selectedCurrency, provider.currencies),
          builder: (context, data, child) {
            final selectedCurrency = data.$1;
            final currencies = data.$2;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.lightGrey.withValues(alpha: 0.5),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCurrency,
                  isExpanded: true,
                  icon: const Icon(IconsaxPlusLinear.arrow_down_1, size: 18),
                  items:
                      currencies.map((String currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(
                            currency,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.blackText,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      context.read<AddItemProvider>().setCurrency(newValue);
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
