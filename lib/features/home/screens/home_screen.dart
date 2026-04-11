import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../../layout/providers/layout_provider.dart';
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
      tabIndex: 1,
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
      tabIndex: 2,
    ),
    HomeServiceItem(
      title: 'Pay Customs Fees',
      subtitle: 'Secure payment for duties and taxes.',
      icon: Icons.credit_card_outlined,
      tabIndex: 3,
    ),
    HomeServiceItem(
      title: 'Shipment History',
      subtitle: 'View logs of all your past clearances.',
      icon: Icons.history_rounded,
      tabIndex: 1,
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
    final layoutProvider = context.read<LayoutProvider>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
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
                layoutProvider.setIndex(1);
              },
            ),
            ServicesSection(
              services: services,
              onServiceTap: (item) {
                if (item.tabIndex != null) {
                  layoutProvider.setIndex(item.tabIndex!);
                } else if (item.route != null) {
                  Navigator.pushNamed(context, item.route!);
                }
              },
            ),
            RecentUpdateCard(
              onTap: () {
                layoutProvider.setIndex(1);
              },
            ),
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
  final String? route;
  final int? tabIndex;

  const HomeServiceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.route,
    this.tabIndex,
  });
}