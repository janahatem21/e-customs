import 'package:e_customs/core/utils/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/services/firebase_services.dart';
import '../../../../../core/widgets/app_button.dart';
import '../provider/add_item_provider.dart';
import '../widgets/add_item_category_dropdown.dart';
import '../widgets/add_item_currency_dropdown.dart';
import '../widgets/add_item_quantity_stepper.dart';
import '../widgets/pending_items_list.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_card.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AddItemProvider>();
      provider.addListener(_onStateChange);
    });
  }

  void _onStateChange() {
    if (!mounted) return;
    final provider = context.read<AddItemProvider>();

    if (provider.isSuccess) {
      AppDialogs.showSuccessSnackBar(context, 'Items added successfully');
      Navigator.pop(context);
    } else if (provider.state == AddItemState.error &&
        provider.errorMessage != null) {
      AppDialogs.showErrorSnackBar(context, provider.errorMessage!);
      provider.resetState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final declarationId =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';
    final provider = context.watch<AddItemProvider>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (provider.pendingItems.isNotEmpty ||
            provider.nameController.text.isNotEmpty ||
            provider.priceController.text.isNotEmpty) {
          final shouldPop = await AppDialogs.showDiscardDialog(context);
          if (shouldPop == true && context.mounted) {
            Navigator.pop(context);
          }
        } else {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.gradientTop,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(
              IconsaxPlusLinear.arrow_left,
              color: AppColors.blackText,
            ),
          ),
          title: const Text('Add Items'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildItemForm(provider),
                      const PendingItemsList(),
                    ],
                  ),
                ),
              ),
              _buildBottomAction(declarationId, provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemForm(AddItemProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Item Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.blackText,
              ),
            ),
            const SizedBox(height: 20),
            AppInput(
              label: 'Product Name',
              hintText: 'e.g. iPhone 15 Pro',
              controller: provider.nameController,
              prefixIcon: const Icon(IconsaxPlusLinear.box, size: 20),
            ),
            const SizedBox(height: 16),
            const AddItemCategoryDropdown(),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: AppInput(
                    label: 'Price',
                    hintText: '0.00',
                    controller: provider.priceController,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(IconsaxPlusLinear.money_3, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: AddItemCurrencyDropdown(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Quantity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.blackText,
              ),
            ),
            const SizedBox(height: 8),
            const AddItemQuantityStepper(),
            const SizedBox(height: 24),
            AppButton(
              text: 'Add to List',
              variant: AppButtonVariant.outline,
              onPressed: provider.addItemToList,
              leadingIcon: const Icon(IconsaxPlusLinear.add, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(String declarationId, AddItemProvider provider) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: AppButton(
        text: 'Save All Items (${provider.pendingItems.length})',
        isLoading: provider.isLoading,
        onPressed: provider.pendingItems.isEmpty
            ? null
            : () {
                final userId = getIt<FirebaseServices>().currentUser?.uid;
                if (userId != null) {
                  provider.saveAllItems(
                    userId: userId,
                    declarationId: declarationId,
                  );
                }
              },
        trailingIcon: const Icon(IconsaxPlusLinear.tick_circle, size: 20),
      ),
    );
  }
}
