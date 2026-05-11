import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/customs_constants.dart';
import '../../../../core/widgets/app_card.dart';
import '../../data/models/declaration_model.dart';
import 'calculate_summary_row.dart';

class CalculateSummaryCard extends StatelessWidget {
  final DeclarationModel declaration;
  final int itemCount;

  const CalculateSummaryCard({
    super.key,
    required this.declaration,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CalculateSummaryRow(
            label: 'Total Items',
            value: itemCount.toString(),
            isSmall: true,
          ),
          const SizedBox(height: 16),
          CalculateSummaryRow(
            label: 'Customs Fees',
            value: '${declaration.totalCustoms.toStringAsFixed(2)} USD',
          ),
          const SizedBox(height: 12),
          CalculateSummaryRow(
            label: 'VAT (${(vatRate * 100).toInt()}%)',
            value: '${declaration.totalVAT.toStringAsFixed(2)} USD',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: AppColors.lightGrey, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Final Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${declaration.totalAmount.toStringAsFixed(2)} USD',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                      letterSpacing: -1,
                    ),
                  ).animate().scale(
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                        begin: const Offset(0.8, 0.8),
                      ),
                  Text(
                    'Total Payable',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
