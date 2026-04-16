import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../provider/upload_documents_provider.dart';
import '../widgets/regulation_notice.dart';
import '../widgets/section_header.dart';
import '../widgets/stepper_indicator.dart';
import '../widgets/upload_area.dart';

class UploadDocumentsScreen extends StatelessWidget {
  const UploadDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UploadDocumentsProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              StepperIndicator(
                currentStep: provider.currentStep,
              ).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 32),
              const RegulationNotice()
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 100.ms)
                  .slideY(begin: 0.1, end: 0),
              const SizedBox(height: 32),

              Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SectionHeader(
                        icon: IconsaxPlusLinear.box,
                        title: "Item Details",
                        subtitle: "Describe the contents of your shipment",
                      ),
                      const SizedBox(height: 24),
                      const AppInput(
                        label: "Product Name",
                        hintText: "e.g. MacBook Pro 14 M3",
                      ),
                      const SizedBox(height: 20),
                      _buildDropdown(
                        context: context,
                        label: "Category",
                        hint: "Electronics & Gadgets",
                        items: [
                          "Electronics & Gadgets",
                          "Clothing",
                          "Food",
                          "Other",
                        ],
                        value: provider.category,
                        onChanged: provider.setCategory,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: AppInput(
                              label: "Quantity",
                              hintText: "1",
                              keyboardType: TextInputType.number,
                              onChanged:
                                  (val) => provider.setQuantity(
                                    int.tryParse(val) ?? 1,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildDropdown(
                              context: context,
                              label: "Origin Country",
                              hint: "United States",
                              items: [
                                "United States",
                                "Egypt",
                                "UK",
                                "Germany",
                              ],
                              value: provider.originCountry,
                              onChanged: provider.setOriginCountry,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 200.ms)
                  .slideY(begin: 0.05, end: 0),

              const SizedBox(height: 48),
              Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SectionHeader(
                        icon: IconsaxPlusLinear.card,
                        title: "Financial Information",
                        subtitle: "Value and shipment cost details",
                      ),
                      const SizedBox(height: 24),
                      AppInput(
                        label: "Declared Shipment Value (USD)",
                        hintText: "0.00",
                        prefixIcon: const Icon(
                          Icons.attach_money_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged:
                            (val) => provider.setDeclaredValue(
                              double.tryParse(val) ?? 0.0,
                            ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 300.ms)
                  .slideY(begin: 0.05, end: 0),

              const SizedBox(height: 48),
              Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SectionHeader(
                        icon: IconsaxPlusLinear.document_text_1,
                        title: "Supporting Documents",
                        subtitle: "Mandatory files for verification",
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 8),
                        child: Text(
                          "Commercial Invoice",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      UploadArea(
                        label: "Click or Drag Invoice",
                        subLabel: "PDF, JPG or PNG (Max 5MB)",
                        onSelect: () {},
                      ),
                      const SizedBox(height: 16),
                      _OptionalAddButton(
                        title: "Add Packing List (Optional)",
                        onPressed: () {},
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 400.ms)
                  .slideY(begin: 0.05, end: 0),

              const SizedBox(height: 48),
              AppButton(
                    text: "Review & Calculate Fees",
                    onPressed: () {},
                    shimmer: true,
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 500.ms)
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1, 1),
                  ),
              const SizedBox(height: 16),
              const _LegalText().animate().fadeIn(
                duration: 400.ms,
                delay: 600.ms,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required List<String> items,
    String? value,
    required ValueChanged<String?> onChanged,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label, style: Theme.of(context).textTheme.labelMedium),
        ),
        DropdownButtonFormField<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          decoration: InputDecoration(hintText: hint),
          items:
              items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _OptionalAddButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _OptionalAddButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.gradientLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gradientMid),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.add_circle_outline_rounded,
              size: 20,
              color: AppColors.subtitleColor,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.subtitleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegalText extends StatelessWidget {
  const _LegalText();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 11),
            children: [
              const TextSpan(
                text:
                    "By submitting this form, you certify that all information is\naccurate and you agree to the ",
              ),
              TextSpan(
                text: "Terms of Service",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontSize: 11,
                ),
              ),
              const TextSpan(text: "."),
            ],
          ),
        ),
      ],
    );
  }
}
