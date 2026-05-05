import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/user_provider.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../core/widgets/app_button.dart';
import '../provider/calculate_provider.dart';
import '../provider/declaration_provider.dart';

class CalculateActions extends StatelessWidget {
  const CalculateActions({super.key});

  Future<void> _onConfirm(BuildContext context) async {
    final calculateProvider = context.read<CalculateProvider>();
    final userProvider = context.read<UserProvider>();
    final declarationProvider = context.read<DeclarationProvider>();

    final userId = userProvider.user?.id;
    final declarationId = declarationProvider.currentDeclarationId;

    if (userId == null || declarationId == null) {
      AppDialogs.showErrorSnackBar(context, 'Missing user or declaration data');
      return;
    }

    try {
      await calculateProvider.confirm(
        userId: userId,
        declarationId: declarationId,
      );

      if (context.mounted) {
        Navigator.pushNamed(context, AppRouter.payment, arguments: declarationId);
      }
    } catch (e) {
      if (context.mounted) {
        AppDialogs.showErrorSnackBar(context, 'Failed to confirm: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Consumer<CalculateProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                text: 'Confirm & Proceed',
                isLoading: provider.isConfirming,
                onPressed: () => _onConfirm(context),
                trailingIcon: const Icon(
                  IconsaxPlusLinear.tick_circle,
                  size: 20,
                ),
              ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms),
              const SizedBox(height: 12),
              AppButton(
                text: 'Back to Edit Items',
                variant: AppButtonVariant.outline,
                onPressed:
                    provider.isConfirming ? null : () => Navigator.pop(context),
              ).animate().slideY(
                begin: 0.2,
                end: 0,
                delay: 100.ms,
                duration: 400.ms,
              ),
            ],
          );
        },
      ),
    );
  }
}
