import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/providers/user_provider.dart';
import '../provider/payment_provider.dart';
import '../widgets/payment_summary_card.dart';
import '../widgets/payment_method_selector.dart';
import '../widgets/payment_card_form.dart';
import '../widgets/payment_wallet_form.dart';
import '../widgets/payment_security_indicator.dart';
import '../widgets/payment_actions.dart';

class PaymentScreen extends StatefulWidget {
  final String? declarationId;
  const PaymentScreen({super.key, this.declarationId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final userId = context.read<UserProvider>().user?.id;
    if (userId != null && widget.declarationId != null) {
      context.read<PaymentProvider>().getDeclaration(
            userId: userId,
            declarationId: widget.declarationId!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Payment'),
      ),
      body: Selector<PaymentProvider, bool>(
        selector: (_, p) => p.isInitialLoading,
        builder: (context, isLoading, child) {
          return Skeletonizer(
            enabled: isLoading,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PaymentSummaryCard(),
                  const SizedBox(height: 32),
                  const Text(
                    'Select Payment Method',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const PaymentMethodSelector(),
                  const SizedBox(height: 32),
                  const _DynamicDetailsSection(),
                  const SizedBox(height: 40),
                  const PaymentSecurityIndicator(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const PaymentActions(),
    );
  }
}

class _DynamicDetailsSection extends StatelessWidget {
  const _DynamicDetailsSection();

  @override
  Widget build(BuildContext context) {
    return Selector<PaymentProvider, AppPaymentMethod>(
      selector: (_, provider) => provider.selectedMethod,
      builder: (context, method, child) {
        return AnimatedSwitcher(
          duration: 300.ms,
          child:
              method == AppPaymentMethod.card
                  ? const PaymentCardForm()
                  : const PaymentWalletForm(),
        );
      },
    );
  }
}
