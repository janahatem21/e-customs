import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/services/firebase_services.dart';
import '../../../../core/routes/app_router.dart';
import '../../customs/presentation/provider/declaration_provider.dart';
import '../models/quick_action.dart';
import 'package:provider/provider.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = QuickAction.defaultActions;

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

          return _PremiumActionCard(
                title: action.title,
                subtitle: action.subtitle,
                icon: action.icon,
                color: action.color,
                onTap: () async {
                  if (action.route == AppRouter.addItem) {
                    final userId = getIt<FirebaseServices>().currentUser?.uid;
                    if (userId != null) {
                      final declarationProvider = context.read<DeclarationProvider>();
                      final id = await declarationProvider.ensureActiveDeclaration(userId);
                      
                      if (!context.mounted) return;
                      
                      if (id != null) {
                        Navigator.pushNamed(
                          context, 
                          AppRouter.addItem, 
                          arguments: id,
                        );
                      } else {
                        Navigator.pushNamed(context, AppRouter.createDeclaration);
                      }
                    }
                    return;
                  }
                  
                  if (action.route != null) {
                    Navigator.pushNamed(context, action.route!);
                  }
                },
              )
              .animate()
              .fadeIn(delay: (200 + (index * 80)).ms, duration: 500.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack);
        },
      ),
    );
  }
}

class _PremiumActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _PremiumActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Decorative background element
              Positioned(
                right: -15,
                top: -15,
                child: Icon(
                  icon,
                  size: 80,
                  color: color.withValues(alpha: 0.04),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withValues(alpha: 0.8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(icon, size: 24, color: Colors.white),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.blackText,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: AppColors.greyText.withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
