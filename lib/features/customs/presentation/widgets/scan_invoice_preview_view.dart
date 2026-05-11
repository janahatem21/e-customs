import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/app_card.dart';
import '../provider/scan_invoice_provider.dart';
import '../provider/declaration_provider.dart';
import '../../../../../core/utils/app_dialogs.dart';
import 'scan_invoice_step_indicator.dart';
import 'scan_invoice_bottom_actions.dart';
import 'scan_invoice_editable_item_card.dart';

class ScanInvoicePreviewView extends StatelessWidget {
  final ScanInvoiceProvider provider;

  const ScanInvoicePreviewView({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('preview'),
      children: [
        const ScanInvoiceStepIndicator(step: 2),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            itemCount: provider.items.length + 2, // + Header + Info
            itemBuilder: (context, index) {
              if (index == 0) {
                return const _PreviewHeader();
              }
              if (index == provider.items.length + 1) {
                return const _PreviewInfoCard();
              }

              final itemIndex = index - 1;
              final item = provider.items[itemIndex];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ScanInvoiceEditableItemCard(
                      item: item,
                      onDelete: () => provider.removeItem(itemIndex),
                      onUpdate:
                          (updated) => provider.updateItem(
                            itemIndex,
                            name: updated.name,
                            price: updated.price,
                            quantity: updated.quantity,
                            category: updated.category,
                          ),
                    )
                    .animate()
                    .fadeIn(delay: (index * 100).ms)
                    .slideY(begin: 0.1, end: 0),
              );
            },
          ),
        ),
        ScanInvoiceBottomActions(
          primaryText: 'Confirm & Save',
          isLoading: provider.isSaving,
          onPrimary: () async {
            final declarationProvider = context.read<DeclarationProvider>();
            final success = await provider.confirmAndSave(
              context,
              declarationProvider,
            );
            if (success && context.mounted) {
              AppDialogs.showSuccessDialog(
                context,
                title: 'Items Saved!',
                message:
                    'Your items have been successfully added to your declaration.',
                onConfirm: () {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('/layout', (route) => false);
                },
              );
            }
          },
          secondaryText: 'Discard',
          onSecondary: provider.reset,
        ),
      ],
    );
  }
}

class _PreviewHeader extends StatelessWidget {
  const _PreviewHeader();

  @override
  Widget build(BuildContext context) {
    final count = context.select<ScanInvoiceProvider, int>(
      (p) => p.items.length,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detected Items',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.blackText,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Gemini AI found $count items',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.subtitleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              '$count items',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.1, end: 0);
  }
}

class _PreviewInfoCard extends StatelessWidget {
  const _PreviewInfoCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: AppCard(
        padding: const EdgeInsets.all(16),
        color: AppColors.info.withValues(alpha: 0.05),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.1)),
        child: const Row(
          children: [
            Icon(
              IconsaxPlusLinear.info_circle,
              color: AppColors.info,
              size: 22,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Please verify the data. You can refine any field or change the category if the AI missed it.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.blackText,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0);
  }
}
