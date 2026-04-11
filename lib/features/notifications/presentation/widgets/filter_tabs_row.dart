import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/features/notifications/data/entities/notification_entity.dart';
import 'package:e_customs/features/notifications/presentation/providers/notification_provider.dart';

class FilterTabsRow extends StatelessWidget {
  const FilterTabsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.lightGrey, width: 0.5),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Row(
              children: [
                _FilterChip(
                  label: 'All',
                  isSelected: provider.selectedType == null,
                  onTap: () => provider.setFilter(null),
                ),
                ...NotificationType.values.map((type) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: _FilterChip(
                      label: type.label,
                      isSelected: provider.selectedType == type,
                      onTap: () => provider.setFilter(type),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blackText : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.blackText : AppColors.lightGrey,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.subtitleColor,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
