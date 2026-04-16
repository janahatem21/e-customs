import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/layout_provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutProvider = context.watch<LayoutProvider>();
    final currentIndex = layoutProvider.currentIndex;

    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Smooth Sliding Background
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            left:
                (MediaQuery.of(context).size.width / 5) * currentIndex +
                (MediaQuery.of(context).size.width / 10) -
                28,
            top: 15,
            child: Container(
              width: 56,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          // Navigation Items
          Row(
            children: [
              _NavItem(
                index: 0,
                currentIndex: currentIndex,
                activeIcon: IconsaxPlusBold.home_1,
                inactiveIcon: IconsaxPlusLinear.home_1,
                label: 'Home',
                onTap: () => layoutProvider.setIndex(0),
              ),
              _NavItem(
                index: 1,
                currentIndex: currentIndex,
                activeIcon: IconsaxPlusBold.location,
                inactiveIcon: IconsaxPlusLinear.location,
                label: 'Track',
                onTap: () => layoutProvider.setIndex(1),
              ),
              _NavItem(
                index: 2,
                currentIndex: currentIndex,
                activeIcon: IconsaxPlusBold.document,
                inactiveIcon: IconsaxPlusLinear.document,
                label: 'Docs',
                onTap: () => layoutProvider.setIndex(2),
              ),
              _NavItem(
                index: 3,
                currentIndex: currentIndex,
                activeIcon: IconsaxPlusBold.card,
                inactiveIcon: IconsaxPlusLinear.card,
                label: 'Fees',
                onTap: () => layoutProvider.setIndex(3),
              ),
              _NavItem(
                index: 4,
                currentIndex: currentIndex,
                activeIcon: IconsaxPlusBold.user,
                inactiveIcon: IconsaxPlusLinear.user,
                label: 'Profile',
                onTap: () => layoutProvider.setIndex(4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                );
              },
              child: Icon(
                isActive ? activeIcon : inactiveIcon,
                key: ValueKey<bool>(isActive),
                size: 24,
                color: isActive ? AppColors.primary : AppColors.subtitleColor,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 0.2,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.subtitleColor,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
