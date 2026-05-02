import 'package:e_customs/core/utils/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../provider/add_item_provider.dart';
import '../widgets/add_item_bottom_buttons.dart';
import '../widgets/add_item_progress_indicator.dart';
import '../widgets/add_item_step1.dart';
import '../widgets/add_item_step2.dart';
import '../widgets/add_item_step3.dart';

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
      AppDialogs.showSuccessSnackBar(context, 'Item added successfully');
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

        if (provider.nameController.text.isNotEmpty ||
            provider.priceController.text.isNotEmpty ||
            provider.currentStep > 0) {
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
          title: const Text('Add New Item'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const AddItemProgressIndicator(),
              const Expanded(child: _AddItemPageView()),
              AddItemBottomButtons(declarationId: declarationId),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Note: The listener is removed automatically when the provider is disposed
    // if we use context.read in initState, but it's safer to handle if we want.
    // However, AddItemProvider is provided via ChangeNotifierProvider which handles disposal.
    super.dispose();
  }
}

class _AddItemPageView extends StatelessWidget {
  const _AddItemPageView();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddItemProvider>();

    return PageView(
      controller: provider.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [AddItemStep1(), AddItemStep2(), AddItemStep3()],
    );
  }
}
