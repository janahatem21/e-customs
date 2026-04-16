import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../provider/fees_provider.dart';
import '../../domain/entities/fee_entity.dart';
import '../widgets/fees_header_card.dart';
import '../widgets/fee_breakdown_item.dart';
import '../widgets/payment_info_note.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Header Card with basic info
            Selector<FeesProvider, (String, double, String)>(
              selector: (_, p) => (p.shipmentId, p.totalAmount, p.currency),
              builder: (context, data, _) {
                return FeesHeaderCard(
                  shipmentId: data.$1,
                  totalAmount: data.$2,
                  currency: data.$3,
                );
              },
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 32),

            // Breakdown Section
            _buildSectionHeader(
              context,
              title: "Detailed Breakdown",
              onAction: () {},
            ).animate().fadeIn(duration: 400.ms, delay: 150.ms),

            const SizedBox(height: 16),

            Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Selector<FeesProvider, List<FeeEntity>>(
                    selector: (_, p) => p.breakdown,
                    builder: (context, breakdown, _) {
                      return Column(
                        children:
                            breakdown.map((item) {
                              return FeeBreakdownItem(
                                title: item.title,
                                description: item.description,
                                amount: item.amount,
                                icon: item.icon,
                              );
                            }).toList(),
                      );
                    },
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms, delay: 200.ms)
                .slideY(begin: 0.05, end: 0),

            const SizedBox(height: 32),

            // Information Note
            Selector<FeesProvider, (String, double)>(
              selector: (_, p) => (p.invoiceNumber, p.declaredValue),
              builder: (context, data, _) {
                return PaymentInfoNote(
                  invoiceNumber: data.$1,
                  declaredValue: data.$2,
                );
              },
            ).animate().fadeIn(duration: 400.ms, delay: 350.ms),

            const SizedBox(height: 40),

            // Action Button
            Selector<FeesProvider, double>(
                  selector: (_, p) => p.totalAmount,
                  builder: (context, total, _) {
                    return AppButton(
                      text: "Pay Now (€${total.toStringAsFixed(2)})",
                      onPressed: () {},
                      shimmer: true,
                    );
                  },
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 500.ms)
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),

            const SizedBox(height: 16),
            Text(
              "Secure encryption protected by Government Gateway Service",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color: AppColors.subtitleColor.withValues(alpha: 0.7),
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 600.ms),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required VoidCallback onAction,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.blackText,
            fontSize: 18,
          ),
        ),
        TextButton.icon(
          onPressed: onAction,
          icon: const Icon(Icons.info_outline, size: 16),
          label: const Text("View Policy"),
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
