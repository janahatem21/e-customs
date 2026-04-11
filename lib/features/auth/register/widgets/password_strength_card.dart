import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PasswordStrengthCard extends StatelessWidget {
  final String password;
  const PasswordStrengthCard({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    bool hasMinLength = password.length >= 8;
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );

    int metCount =
        [
          hasMinLength,
          hasUppercase,
          hasDigits,
          hasSpecialCharacters,
        ].where((met) => met).length;

    double progress = metCount / 4;
    Color strengthColor =
        progress < 0.3
            ? Colors.red
            : progress < 0.7
            ? Colors.orange
            : Colors.green;
    String strengthText =
        progress < 0.3
            ? 'Weak'
            : progress < 0.7
            ? 'Medium'
            : 'Strong';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Password Security',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: strengthColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  strengthText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: strengthColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.lightGrey.withValues(alpha: 0.3),
              color: strengthColor,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RequirementChip(label: '8+ Characters', isMet: hasMinLength),
              _RequirementChip(label: 'Uppercase', isMet: hasUppercase),
              _RequirementChip(
                label: 'Special Character',
                isMet: hasSpecialCharacters,
              ),
              _RequirementChip(label: 'Number', isMet: hasDigits),
            ],
          ),
        ],
      ),
    );
  }
}

class _RequirementChip extends StatelessWidget {
  final String label;
  final bool isMet;

  const _RequirementChip({required this.label, required this.isMet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color:
            isMet
                ? Colors.green.withValues(alpha: 0.1)
                : AppColors.lightGrey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet ? Icons.check_circle_rounded : Icons.circle_outlined,
            size: 12,
            color:
                isMet
                    ? Colors.green
                    : AppColors.subtitleColor.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color:
                  isMet
                      ? Colors.green.withValues(alpha: 0.8)
                      : AppColors.subtitleColor.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
