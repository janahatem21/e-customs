import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/services/firebase_services.dart';
import '../../../../../core/widgets/app_button.dart';
import '../provider/add_item_provider.dart';

class AddItemBottomButtons extends StatelessWidget {
  final String declarationId;

  const AddItemBottomButtons({
    super.key,
    required this.declarationId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Selector<AddItemProvider, (int, bool)>(
        selector: (_, provider) => (provider.currentStep, provider.isLoading),
        builder: (context, data, child) {
          final currentStep = data.$1;
          final isLoading = data.$2;
          final provider = context.read<AddItemProvider>();
          
          return Row(
            children: [
              if (currentStep > 0) ...[
                Expanded(
                  child: AppButton(
                    text: 'Back',
                    variant: AppButtonVariant.outline,
                    onPressed: isLoading ? null : provider.previousStep,
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                flex: 2,
                child: AppButton(
                  text: currentStep == 2 ? 'Add Item' : 'Continue',
                  isLoading: isLoading,
                  onPressed: () {
                    if (currentStep == 2) {
                      final userId = getIt<FirebaseServices>().currentUser?.uid;
                      if (userId != null) {
                        provider.addItem(
                          userId: userId,
                          declarationId: declarationId,
                        );
                      }
                    } else {
                      provider.nextStep();
                    }
                  },
                  trailingIcon: currentStep == 2
                      ? const Icon(IconsaxPlusLinear.add_square, size: 20)
                      : const Icon(IconsaxPlusLinear.arrow_right_3, size: 20),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
