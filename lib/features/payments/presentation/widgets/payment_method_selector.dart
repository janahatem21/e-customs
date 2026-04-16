import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PaymentMethodSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelected;

  const PaymentMethodSelector({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Stack(
        children: [
          // Sliding Indicator
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            alignment:
                selectedIndex == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildItem(
                  context,
                  index: 0,
                  icon: Icons.credit_card_rounded,
                  label: "Credit Card",
                  isSelected: selectedIndex == 0,
                ),
              ),
              Expanded(
                child: _buildItem(
                  context,
                  index: 1,
                  icon: Icons.account_balance_wallet_rounded,
                  label: "Digital Wallet",
                  isSelected: selectedIndex == 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.primary : AppColors.subtitleColor,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color:
                    isSelected ? AppColors.blackText : AppColors.subtitleColor,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
