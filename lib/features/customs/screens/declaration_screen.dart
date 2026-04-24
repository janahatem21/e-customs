import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/core/widgets/app_button.dart';
import 'package:e_customs/core/widgets/app_card.dart';
import 'package:e_customs/core/routes/app_router.dart';

class DeclarationScreen extends StatefulWidget {
  const DeclarationScreen({super.key});

  @override
  State<DeclarationScreen> createState() => _DeclarationScreenState();
}

class _DeclarationScreenState extends State<DeclarationScreen> {
  // Mock data for demonstration
  final List<Map<String, dynamic>> _items = [
    {
      'id': '1',
      'name': 'iPhone 15 Pro',
      'category': 'Electronics',
      'price': 1200.00,
      'currency': 'USD',
      'quantity': 1,
    },
    {
      'id': '2',
      'name': 'MacBook Air M3',
      'category': 'Laptops',
      'price': 1099.00,
      'currency': 'USD',
      'quantity': 1,
    },
    {
      'id': '3',
      'name': 'Sony WH-1000XM5',
      'category': 'Audio',
      'price': 348.00,
      'currency': 'USD',
      'quantity': 2,
    },
  ];

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  double get _totalValue {
    return _items.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
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
        title: const Column(
          children: [
            Text(
              'Declaration',
              style: TextStyle(
                color: AppColors.blackText,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Review your declared items',
              style: TextStyle(
                color: AppColors.greyText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          if (_items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed:
                    () => Navigator.pushNamed(context, AppRouter.addItem),
                icon: const Icon(
                  IconsaxPlusLinear.add_square,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: 400.ms,
                child: _items.isEmpty ? _buildEmptyState() : _buildItemsList(),
              ),
            ),
            if (_items.isNotEmpty) _buildBottomSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              IconsaxPlusLinear.document_text_1,
              size: 64,
              color: AppColors.primary,
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 24),
          const Text(
            'No items declared yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 12),
          const Text(
            'Start by scanning an invoice or adding items manually to calculate your customs.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.greyText,
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 40),
          AppButton(
            text: 'Scan Invoice',
            onPressed:
                () => Navigator.pushNamed(context, AppRouter.scanInvoice),
            leadingIcon: const Icon(IconsaxPlusLinear.camera, size: 20),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 16),
          AppButton(
            text: 'Add Item Manually',
            variant: AppButtonVariant.outline,
            onPressed: () => Navigator.pushNamed(context, AppRouter.addItem),
            leadingIcon: const Icon(IconsaxPlusLinear.add_square, size: 20),
          ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: _items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildItemCard(
          item,
          index,
        ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1, end: 0);
      },
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item, int index) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left status indicator or Category Icon
              Container(
                width: 6,
                color: AppColors.primary.withOpacity(0.8),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCategoryChip(item['category']),
                          Row(
                            children: [
                              _buildActionIcon(
                                IconsaxPlusLinear.edit_2,
                                AppColors.primary,
                                () {},
                              ),
                              const SizedBox(width: 8),
                              _buildActionIcon(
                                IconsaxPlusLinear.trash,
                                AppColors.error,
                                () => _removeItem(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Qty: ${item['quantity']}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.greyText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${(item['price'] * item['quantity']).toStringAsFixed(2)} ${item['currency']}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Items: ${_items.length}',
                    style: const TextStyle(
                      color: AppColors.greyText,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Declared Value',
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                '${_totalValue.toStringAsFixed(2)} USD',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Proceed to Calculation',
            onPressed: () => Navigator.pushNamed(context, AppRouter.calculateCustoms),
            trailingIcon: const Icon(IconsaxPlusLinear.arrow_right_3, size: 20),
          ),
        ],
      ),
    ).animate().slideY(
      begin: 0.2,
      end: 0,
      duration: 400.ms,
      curve: Curves.easeOut,
    );
  }
}
