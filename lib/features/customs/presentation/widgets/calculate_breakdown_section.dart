import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/customs_constants.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/item_entity.dart';
import 'calculate_breakdown_item.dart';

class CalculateBreakdownSection extends StatelessWidget {
  final List<ItemEntity> items;

  const CalculateBreakdownSection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Itemized Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final rate = customsRates[item.category.toLowerCase()] ?? 0.15;
              final fee = item.price * item.quantity * rate;

              return Column(
                children: [
                  CalculateBreakdownItem(
                    name: item.name,
                    category: item.category,
                    fee: '${fee.toStringAsFixed(2)} USD',
                  ),
                  if (index < items.length - 1)
                    const Divider(
                      color: AppColors.lightGrey,
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
