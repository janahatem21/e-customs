import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppInput extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;

  const AppInput({
    super.key,
    this.label,
    this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.controller,
    this.errorText,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.blackText,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: enabled,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.blackText,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            prefixIcon:
                prefixIcon != null
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: prefixIcon,
                    )
                    : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 40),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
