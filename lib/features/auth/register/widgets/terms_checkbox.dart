import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class TermsCheckbox extends StatelessWidget {
  const TermsCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final bool isChecked = authProvider.agreeToTerms;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: authProvider.toggleAgreeToTerms,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: isChecked ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isChecked ? AppColors.primary : AppColors.lightGrey,
                width: 1.5,
              ),
            ),
            child: isChecked
                ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                : null,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.termsHighlight,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
                TextSpan(
                  text: AppStrings.termsDescription,
                  style: TextStyle(
                    color: AppColors.subtitleColor,
                  ),
                ),
              ],
            ),
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
