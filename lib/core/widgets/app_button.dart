import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

enum AppButtonVariant { primary, outline, ghost, tonal }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool fullWidth;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isLoading;
  final bool shimmer;
  final Color? color;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.fullWidth = true,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.shimmer = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(fullWidth ? double.infinity : 0, 0),
        backgroundColor:
            variant == AppButtonVariant.outline
                ? AppColors.white
                : (variant == AppButtonVariant.ghost
                    ? Colors.transparent
                    : (variant == AppButtonVariant.tonal
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : null)),
        foregroundColor:
            color ??
            (variant == AppButtonVariant.primary
                ? null
                : (variant == AppButtonVariant.tonal
                    ? AppColors.primary
                    : AppColors.blackText)),
        side:
            variant == AppButtonVariant.outline
                ? BorderSide(color: color ?? AppColors.lightGrey)
                : null,
        elevation: variant == AppButtonVariant.primary ? null : 0,
      ),
      child:
          isLoading
              ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: color != null ? TextStyle(color: color) : null,
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    trailingIcon!,
                  ],
                ],
              ),
    );

    if (shimmer && !isLoading) {
      button = button
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .shimmer(delay: 2000.ms, duration: 1500.ms, color: Colors.white24);
    }

    return button;
  }
}
