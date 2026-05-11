import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/firebase_services.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/app_button.dart';
import '../provider/history_provider.dart';
import '../widgets/qr_dialog.dart';

class HistoryDetailsScreen extends StatefulWidget {
  final String declarationId;

  const HistoryDetailsScreen({super.key, required this.declarationId});

  @override
  State<HistoryDetailsScreen> createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = getIt<FirebaseServices>().currentUser?.uid;
      if (userId != null) {
        context.read<HistoryProvider>().loadDeclarationDetails(
          userId: userId,
          declarationId: widget.declarationId,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(IconsaxPlusLinear.arrow_left),
        ),
        title: const Text('Declaration Details'),
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final declaration = provider.selectedDeclaration;
          if (declaration == null) {
            return Center(
              child: Text(
                'Declaration not found',
                style: theme.textTheme.bodyLarge,
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCard(context, declaration),
                const SizedBox(height: 32),
                Text('Items List', style: theme.textTheme.titleMedium),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.declarationItems.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = provider.declarationItems[index];
                    return _buildItemCard(context, item);
                  },
                ),
                const SizedBox(height: 40),
                if (declaration.status == 'paid' && declaration.qrData != null)
                  AppButton(
                    text: 'Show QR Code',
                    leadingIcon: const Icon(
                      IconsaxPlusLinear.scan_barcode,
                      size: 20,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => QRDialog(
                              qrData: declaration.qrData!,
                              declarationId: declaration.id!,
                              status: declaration.status,
                            ),
                      );
                    },
                  ).animate().fadeIn(delay: 400.ms).scale(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, declaration) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusBadge(declaration.status),
              Text(
                declaration.createdAt != null
                    ? DateFormat('MMM dd, yyyy').format(declaration.createdAt!)
                    : 'N/A',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSummaryRow(context, 'Total Customs', declaration.totalCustoms),
          const SizedBox(height: 12),
          _buildSummaryRow(context, 'VAT (14%)', declaration.totalVAT),
          const Divider(height: 32, color: AppColors.lightGrey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${declaration.totalAmount.toStringAsFixed(2)} USD',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 22,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String text;
    switch (status) {
      case 'paid':
        color = AppColors.success;
        text = 'PAID';
        break;
      case 'calculated':
        color = AppColors.warning;
        text = 'READY TO PAY';
        break;
      default:
        color = AppColors.greyText;
        text = 'DRAFT';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, double amount) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        Text(
          '${amount.toStringAsFixed(2)} USD',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.blackText,
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(BuildContext context, item) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              IconsaxPlusLinear.box,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.category} • Qty: ${item.quantity}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            '${item.price.toStringAsFixed(2)} ${item.currency}',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
