import 'package:e_customs/core/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/user_provider.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../provider/calculate_provider.dart';
import '../provider/declaration_provider.dart';
import '../widgets/calculate_summary_card.dart';
import '../widgets/calculate_breakdown_section.dart';
import '../widgets/calculate_trust_indicator.dart';
import '../widgets/calculate_actions.dart';
import '../widgets/calculate_loading_state.dart';

class CalculateCustomsScreen extends StatefulWidget {
  const CalculateCustomsScreen({super.key});

  @override
  State<CalculateCustomsScreen> createState() => _CalculateCustomsScreenState();
}

class _CalculateCustomsScreenState extends State<CalculateCustomsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCalculation();
    });
  }

  Future<void> _startCalculation() async {
    final calculateProvider = context.read<CalculateProvider>();
    final userProvider = context.read<UserProvider>();
    final declarationProvider = context.read<DeclarationProvider>();

    // 1. Wait for user to be loaded if currently fetching
    if (userProvider.isLoading) {
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        return userProvider.isLoading;
      });
    }

    final userId = userProvider.user?.id;
    if (userId == null) {
      if (mounted) {
        AppDialogs.showErrorSnackBar(context, 'Please log in to continue');
      }
      return;
    }

    // 2. Try to get declaration ID from provider, or fetch active if null
    String? declarationId = declarationProvider.currentDeclarationId;
    declarationId ??= await declarationProvider.ensureActiveDeclaration(userId);

    if (declarationId == null) {
      if (mounted) {
        AppDialogs.showErrorSnackBar(
          context,
          'No active declaration found to calculate',
        );
        calculateProvider.markAsInitialized();
      }
      return;
    }

    try {
      await calculateProvider.calculate(
        userId: userId,
        declarationId: declarationId,
      );
    } catch (e) {
      if (mounted) {
        AppDialogs.showErrorSnackBar(context, 'Calculation failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Calculate Customs'),
      ),
      body: Consumer<CalculateProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading || !provider.isInitialized) {
            return const CalculateLoadingState();
          }

          final declaration = provider.declaration;
          final items = provider.items;

          if (declaration == null) {
            return const Center(child: Text('No calculation data found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CalculateSummaryCard(
                  declaration: declaration,
                  itemCount: items.length,
                ),
                const SizedBox(height: 24),
                CalculateBreakdownSection(items: items),
                const SizedBox(height: 32),
                const CalculateTrustIndicator(),
                const SizedBox(height: 24),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms);
        },
      ),
      bottomNavigationBar: Selector<CalculateProvider, bool>(
        selector:
            (_, provider) => provider.isLoading || !provider.isInitialized,
        builder: (context, isBusy, child) {
          return !isBusy ? const CalculateActions() : const SizedBox.shrink();
        },
      ),
    );
  }
}
