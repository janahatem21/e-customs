import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/widgets/app_card.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> actions = [
      {
        'title': 'Add Item',
        'icon': IconsaxPlusLinear.add_square,
        'color': const Color(0xFF6366F1),
        'subtitle': 'New declaration',
        'route': AppRouter.addItem,
      },
      {
        'title': 'Scan Invoice',
        'icon': IconsaxPlusLinear.document_filter,
        'color': const Color(0xFF10B981),
        'subtitle': 'AI processing',
        'route': AppRouter.scanInvoice,
      },
      {
        'title': 'Declarations',
        'icon': IconsaxPlusLinear.document_text_1,
        'color': const Color(0xFFF59E0B),
        'subtitle': 'History & status',
        'route': AppRouter.declaration,
      },
      {
        'title': 'Calculator',
        'icon': IconsaxPlusLinear.calculator,
        'color': const Color(0xFFEC4899),
        'subtitle': 'Duty estimate',
        'route': AppRouter.calculateCustoms,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        itemCount: actions.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          final action = actions[index];
          final color = action['color'] as Color;
          
          return AppCard(
                padding: const EdgeInsets.all(16),
                onTap: () {
                  if (action.containsKey('route')) {
                    Navigator.pushNamed(context, action['route'] as String);
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        action['icon'] as IconData,
                        size: 24,
                        color: color,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          action['title'] as String,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          action['subtitle'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.greyText,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: (300 + (index * 50)).ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
        },
      ),
    );
  }
}
