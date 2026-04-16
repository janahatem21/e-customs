import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PaymentFormField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final String value;
  final List<dynamic>? inputFormatters;

  const PaymentFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.onChanged,
    required this.value,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.blackText,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.subtitleColor.withValues(alpha: 0.5),
            ),
            filled: true,
            fillColor: AppColors.fieldFill,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: AppColors.subtitleColor, size: 20) : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
