import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../domain/entities/ocr_item_entity.dart';

class ScanInvoiceEditableItemCard extends StatelessWidget {
  final OcrItemEntity item;
  final VoidCallback onDelete;
  final Function(OcrItemEntity) onUpdate;

  const ScanInvoiceEditableItemCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon or Index Placeholder
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  IconsaxPlusLinear.box,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: item.name,
                      decoration: const InputDecoration(
                        hintText: 'Product Name',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.blackText,
                      ),
                      onChanged: (val) => onUpdate(item.copyWith(name: val)),
                    ),
                    const SizedBox(height: 6),
                    _buildCategoryChip(),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDelete,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.error.withValues(alpha: 0.1),
                  foregroundColor: AppColors.error,
                  padding: const EdgeInsets.all(8),
                ),
                icon: const Icon(IconsaxPlusLinear.trash, size: 18),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, color: AppColors.lightGrey),
          ),
          Row(
            children: [
              Expanded(
                child: _buildInfoField(
                  label: 'Price',
                  value: item.price.toString(),
                  icon: IconsaxPlusLinear.money_send,
                  color: AppColors.securityGreen,
                  onChanged: (val) => onUpdate(
                    item.copyWith(price: double.tryParse(val) ?? 0),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildInfoField(
                  label: 'Quantity',
                  value: item.quantity.toString(),
                  icon: IconsaxPlusLinear.box_1,
                  color: AppColors.warning,
                  onChanged: (val) => onUpdate(
                    item.copyWith(quantity: int.tryParse(val) ?? 1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppColors.subtitleColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.subtitleColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color.withValues(alpha: 0.9),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCategoryChip() {
    final List<String> allCategories = List.from(AppConstants.categories);
    if (item.category != null && !allCategories.contains(item.category)) {
      allCategories.add(item.category!);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: item.category,
          hint: const Text(
            'Category',
            style: TextStyle(fontSize: 11, color: AppColors.primary),
          ),
          isDense: true,
          icon: const Icon(
            IconsaxPlusLinear.arrow_down_1,
            size: 12,
            color: AppColors.primary,
          ),
          items: allCategories.map((cat) {
            return DropdownMenuItem(
              value: cat,
              child: Text(
                cat,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              onUpdate(item.copyWith(category: val));
            }
          },
        ),
      ),
    );
  }
}
