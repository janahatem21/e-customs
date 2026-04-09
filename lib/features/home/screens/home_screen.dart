import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/widgets/bottom_nav.dart';
import '../widgets/home_greeting_section.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/quick_track_card.dart';
import '../widgets/recent_update_card.dart';
import '../widgets/services_section.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<HomeServiceItem> services = [
    HomeServiceItem(
      title: 'Track Shipment',
      subtitle: 'Real-time status of your global parcels.',
      icon: Icons.inventory_2_outlined,
      route: AppRouter.track,
    ),
    HomeServiceItem(
      title: 'Customs Declaration',
      subtitle: 'Submit electronic forms for faster clearance.',
      icon: Icons.description_outlined,
      route: AppRouter.customs,
    ),
    HomeServiceItem(
      title: 'Upload Documents',
      subtitle: 'Manage invoices, IDs, and shipping labels.',
      icon: Icons.upload_file_outlined,
      route: AppRouter.documents,
    ),
    HomeServiceItem(
      title: 'Pay Customs Fees',
      subtitle: 'Secure payment for duties and taxes.',
      icon: Icons.credit_card_outlined,
      route: AppRouter.fees,
    ),
    HomeServiceItem(
      title: 'Shipment History',
      subtitle: 'View logs of all your past clearances.',
      icon: Icons.history_rounded,
      route: AppRouter.track,
    ),
    HomeServiceItem(
      title: 'Notifications',
      subtitle: 'Stay updated on shipment changes.',
      icon: Icons.notifications_none_rounded,
      route: AppRouter.notifications,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  HomeTopBar(
                    onNotificationsTap: () {
                      Navigator.pushNamed(context, AppRouter.notifications);
                    },
                  ),
                  const HomeGreetingSection(),
                  QuickTrackCard(
                    onTrackTap: () {
                      Navigator.pushNamed(context, AppRouter.track);
                    },
                  ),
                  ServicesSection(
                    services: services,
                    onServiceTap: (route) {
                      Navigator.pushNamed(context, route);
                    },
                  ),
                  RecentUpdateCard(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.track);
                    },
                  ),
                ],
              ),
            ),
            const BottomNav(currentIndex: 0),
          ],
        ),
      ),
    );
  }
}

class HomeServiceItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  const HomeServiceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}