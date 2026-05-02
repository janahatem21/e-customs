import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/constants/app_colors.dart';

class ScanInvoiceScanLine extends StatelessWidget {
  const ScanInvoiceScanLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 32,
      right: 32,
      child: Container(
            height: 2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0),
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0),
                ],
              ),
            ),
          )
          .animate(onPlay: (controller) => controller.repeat())
          .moveY(
            begin: 100,
            end: 450,
            duration: 2000.ms,
            curve: Curves.easeInOut,
          ),
    );
  }
}
