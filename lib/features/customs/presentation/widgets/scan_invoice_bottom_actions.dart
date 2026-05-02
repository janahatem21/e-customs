import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_button.dart';

class ScanInvoiceBottomActions extends StatelessWidget {
  final String primaryText;
  final VoidCallback onPrimary;
  final Widget? primaryIcon;
  final String? secondaryText;
  final VoidCallback? onSecondary;
  final bool isLoading;

  const ScanInvoiceBottomActions({
    super.key,
    required this.primaryText,
    required this.onPrimary,
    this.primaryIcon,
    this.secondaryText,
    this.onSecondary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (secondaryText != null) ...[
            Expanded(
              child: AppButton(
                text: secondaryText!,
                variant: AppButtonVariant.outline,
                onPressed: isLoading ? null : onSecondary,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            flex: 2,
            child: AppButton(
              text: primaryText,
              onPressed: onPrimary,
              trailingIcon: primaryIcon,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
