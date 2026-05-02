import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../provider/add_item_provider.dart';

class AddItemProgressIndicator extends StatelessWidget {
  const AddItemProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return Expanded(
                child: Selector<AddItemProvider, int>(
                  selector: (_, provider) => provider.currentStep,
                  builder: (context, currentStep, child) {
                    final isActive = index <= currentStep;
                    return Container(
                      height: 4,
                      margin: EdgeInsets.only(right: index == 2 ? 0 : 8),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.lightGrey.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ).animate(target: isActive ? 1 : 0).tint(color: AppColors.primary);
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Selector<AddItemProvider, int>(
                selector: (_, provider) => provider.currentStep,
                builder: (context, currentStep, child) {
                  return Text(
                    'Step ${currentStep + 1} of 3',
                    style: const TextStyle(
                      color: AppColors.greyText,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
              Selector<AddItemProvider, String>(
                selector: (_, provider) => provider.getStepTitle(),
                builder: (context, stepTitle, child) {
                  return Text(
                    stepTitle,
                    style: const TextStyle(
                      color: AppColors.blackText,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
