import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/user_provider.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../customs/presentation/provider/declaration_provider.dart';
import '../provider/payment_provider.dart';

class PaymentActions extends StatelessWidget {
  const PaymentActions({super.key});

  Future<void> _handlePayment(BuildContext context) async {
    final paymentProvider = context.read<PaymentProvider>();
    final userProvider = context.read<UserProvider>();
    final declarationProvider = context.read<DeclarationProvider>();

    final userId = userProvider.user?.id;
    final declarationId = declarationProvider.currentDeclarationId;

    if (userId == null || declarationId == null) {
      AppDialogs.showErrorSnackBar(context, 'Missing user or declaration data');
      return;
    }

    final success = await paymentProvider.pay(
      userId: userId,
      declarationId: declarationId,
    );

    if (success) {
      if (context.mounted) {
        Navigator.pushNamed(context, AppRouter.qrCode, arguments: paymentProvider);
      }
    } else {
      if (context.mounted) {
        AppDialogs.showErrorSnackBar(
          context,
          paymentProvider.errorMessage ?? 'Payment failed',
        );
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
      child: Consumer<PaymentProvider>(
        builder: (context, provider, child) {
          return AppButton(
            text: provider.isLoading ? 'Processing...' : 'Pay Now',
            isLoading: provider.isLoading,
            onPressed: () => _handlePayment(context),
            leadingIcon: const Icon(IconsaxPlusBold.shield_tick, size: 20),
          ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms);
        },
      ),
    );
  }
}
