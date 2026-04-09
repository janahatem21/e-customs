import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../routes/app_router.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;

  const BottomNav({
    super.key,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRouter.home);
        break;
      case 1:
        Navigator.pushNamed(context, AppRouter.track);
        break;
      case 2:
        Navigator.pushNamed(context, AppRouter.documents);
        break;
      case 3:
        Navigator.pushNamed(context, AppRouter.fees);
        break;
      case 4:
        Navigator.pushNamed(context, AppRouter.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.lightGrey.withOpacity(0.5),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(context, 0, Icons.home_outlined, Icons.home, 'Home'),
          _item(context, 1, Icons.location_on_outlined, Icons.location_on, 'Track'),
          _item(context, 2, Icons.description_outlined, Icons.description, 'Docs'),
          _item(context, 3, Icons.credit_card_outlined, Icons.credit_card, 'Payments'),
          _item(context, 4, Icons.person_outline, Icons.person, 'Profile'),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context,
      int index,
      IconData icon,
      IconData activeIcon,
      String label,
      ) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => _onTap(context, index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 20,
              color: isActive
                  ? AppColors.blackText
                  : AppColors.subtitleColor,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? AppColors.blackText
                    : AppColors.subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}