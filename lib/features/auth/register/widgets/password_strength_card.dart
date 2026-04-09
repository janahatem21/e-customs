import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class PasswordStrengthCard extends StatelessWidget {
  final String password;

  const PasswordStrengthCard({
    super.key,
    required this.password,
  });

  bool get hasMinLength => password.length >= 8;
  bool get hasSpecialChar => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(password);
  bool get hasNumber => RegExp(r'[0-9]').hasMatch(password);

  int get score {
    int value = 0;
    if (hasMinLength) value++;
    if (hasSpecialChar) value++;
    if (hasUppercase) value++;
    if (hasNumber) value++;
    return value;
  }

  String get levelText {
    if (score <= 1) return AppStrings.weak;
    if (score == 2 || score == 3) return AppStrings.medium;
    return AppStrings.strong;
  }

  Color get levelColor {
    if (score <= 1) return Colors.red;
    if (score == 2 || score == 3) return Colors.orange;
    return Colors.green;
  }

  double get progressValue {
    if (score == 0) return 0.0;
    return score / 4;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.securityLevel,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.subtitleColor,
                  letterSpacing: 1,
                ),
              ),
              Text(
                levelText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.gradientMid,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progressValue,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: levelColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 4.8,
            children: [
              _RuleItem(
                text: AppStrings.ruleCharacters,
                isDone: hasMinLength,
              ),
              _RuleItem(
                text: AppStrings.ruleSpecialSymbol,
                isDone: hasSpecialChar,
              ),
              _RuleItem(
                text: AppStrings.ruleUppercase,
                isDone: hasUppercase,
              ),
              _RuleItem(
                text: AppStrings.ruleNumber,
                isDone: hasNumber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RuleItem extends StatelessWidget {
  final String text;
  final bool isDone;

  const _RuleItem({
    required this.text,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isDone ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 12,
          color: isDone ? Colors.green : AppColors.subtitleColor,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: isDone ? AppColors.blackText : AppColors.subtitleColor,
            ),
          ),
        ),
      ],
    );
  }
}