import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../core/routes/app_router.dart';

class QuickAction {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? route;

  const QuickAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.route,
  });

  static List<QuickAction> get defaultActions => [
    const QuickAction(
      title: 'Add Item',
      icon: IconsaxPlusBold.add_square,
      color: Color(0xFF6366F1),
      subtitle: 'New declaration',
      route: AppRouter.addItem,
    ),
    const QuickAction(
      title: 'Scan Invoice',
      icon: IconsaxPlusBold.document_filter,
      color: Color(0xFF10B981),
      subtitle: 'AI processing',
      route: AppRouter.scanInvoice,
    ),
    const QuickAction(
      title: 'Calculator',
      icon: IconsaxPlusBold.calculator,
      color: Color(0xFFEC4899),
      subtitle: 'Duty estimate',
      route: AppRouter.calculateCustoms,
    ),
    const QuickAction(
      title: 'Pay Duties',
      icon: IconsaxPlusBold.wallet_1,
      color: Color(0xFFF59E0B),
      subtitle: 'Latest calculated',
      route: AppRouter.payment,
    ),
  ];
}
