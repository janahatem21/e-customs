import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../provider/add_item_provider.dart';

class AddItemQuantityStepper extends StatelessWidget {
  const AddItemQuantityStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            icon: IconsaxPlusLinear.minus,
            onTap: () => context.read<AddItemProvider>().decrementQuantity(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Selector<AddItemProvider, int>(
              selector: (_, provider) => provider.quantity,
              builder: (context, quantity, child) {
                return Text(
                  quantity.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackText,
                  ),
                );
              },
            ),
          ),
          _StepperButton(
            icon: IconsaxPlusLinear.add,
            onTap: () => context.read<AddItemProvider>().incrementQuantity(),
            isPrimary: true,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1, end: 0);
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _StepperButton({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.primary
              : AppColors.lightGrey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isPrimary ? AppColors.white : AppColors.blackText,
        ),
      ),
    );
  }
}
