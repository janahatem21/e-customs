import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/core/routes/app_router.dart';
import 'package:e_customs/core/widgets/app_button.dart';
import 'package:e_customs/core/widgets/app_card.dart';

class CalculateCustomsScreen extends StatefulWidget {
  const CalculateCustomsScreen({super.key});

  @override
  State<CalculateCustomsScreen> createState() => _CalculateCustomsScreenState();
}

class _CalculateCustomsScreenState extends State<CalculateCustomsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading state
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            IconsaxPlusLinear.arrow_left,
            color: AppColors.blackText,
          ),
        ),
        title: const Text(
          'Calculate Customs',
          style: TextStyle(
            color: AppColors.blackText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading ? _buildLoadingState() : _buildLoadedState(),
      bottomNavigationBar: !_isLoading ? _buildActions() : null,
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 3,
          ),
          const SizedBox(height: 24),
          Text(
            'Calculating duties & taxes...',
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ).animate(onPlay: (c) => c.repeat()).shimmer(
                duration: 1500.ms,
                color: AppColors.primary.withOpacity(0.2),
              ),
        ],
      ),
    );
  }

  Widget _buildLoadedState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 24),
          _buildBreakdownSection(),
          const SizedBox(height: 32),
          _buildTrustIndicator(),
          const SizedBox(height: 24),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildSummaryCard() {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildSummaryRow(
            label: 'Total Items',
            value: '4',
            isSmall: true,
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            label: 'Customs Fees',
            value: '\$450.00',
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            label: 'VAT (15%)',
            value: '\$210.50',
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
                    '\$660.50',
                    style: const TextStyle(
                      fontSize: 32,
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
                      color: AppColors.primary.withOpacity(0.6),
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

  Widget _buildSummaryRow({
    required String label,
    required String value,
    bool isSmall = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isSmall ? 13 : 15,
            color: isSmall ? AppColors.greyText : AppColors.blackText,
            fontWeight: isSmall ? FontWeight.w500 : FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isSmall ? 14 : 16,
            color: AppColors.blackText,
            fontWeight: isSmall ? FontWeight.w600 : FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Itemized Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildBreakdownItem(
                name: 'iPhone 15 Pro',
                category: 'Electronics',
                fee: '\$180.00',
              ),
              const Divider(color: AppColors.lightGrey, height: 1, indent: 16, endIndent: 16),
              _buildBreakdownItem(
                name: 'MacBook Air M3',
                category: 'Laptops',
                fee: '\$164.85',
              ),
              const Divider(color: AppColors.lightGrey, height: 1, indent: 16, endIndent: 16),
              _buildBreakdownItem(
                name: 'Sony Headphones',
                category: 'Audio',
                fee: '\$52.20',
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownItem({
    required String name,
    required String category,
    required String fee,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              IconsaxPlusLinear.box,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.greyText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            fee,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.securityGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.securityGreen.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            IconsaxPlusBold.shield_tick,
            color: AppColors.securityGreen,
            size: 24,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Official Calculation',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.securityGreen,
                  ),
                ),
                Text(
                  'Fees are calculated based on current government regulations and tariff rates.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.securityGreenDark,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            text: 'Confirm & Proceed',
            onPressed: () => Navigator.pushNamed(context, AppRouter.payment),
            trailingIcon: const Icon(IconsaxPlusLinear.tick_circle, size: 20),
          ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms),
          const SizedBox(height: 12),
          AppButton(
            text: 'Back to Edit Items',
            variant: AppButtonVariant.outline,
            onPressed: () => Navigator.pop(context),
          ).animate().slideY(begin: 0.2, end: 0, delay: 100.ms, duration: 400.ms),
        ],
      ),
    );
  }
}
