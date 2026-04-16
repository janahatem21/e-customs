import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/app_router.dart';
import '../../layout/providers/layout_provider.dart';
import '../widgets/home_greeting_section.dart';
import '../widgets/quick_track_card.dart';
import '../widgets/recent_update_card.dart';
import '../widgets/services_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<HomeServiceItem> services = [
    HomeServiceItem(
      title: 'Track Shipment',
      subtitle: 'Real-time status of your global parcels.',
      icon: IconsaxPlusLinear.box,
      tabIndex: 1,
    ),
    HomeServiceItem(
      title: 'Customs Declaration',
      subtitle: 'Submit electronic forms for faster clearance.',
      icon: IconsaxPlusLinear.document_text,
      route: AppRouter.customs,
    ),
    HomeServiceItem(
      title: 'Upload Documents',
      subtitle: 'Manage invoices, IDs, and shipping labels.',
      icon: IconsaxPlusLinear.document_upload,
      tabIndex: 2,
    ),
    HomeServiceItem(
      title: 'Pay Customs Fees',
      subtitle: 'Secure payment for duties and taxes.',
      icon: IconsaxPlusLinear.wallet_check,
      tabIndex: 3,
    ),
    HomeServiceItem(
      title: 'Shipment History',
      subtitle: 'View logs of all your past clearances.',
      icon: IconsaxPlusLinear.receipt_2_1,
      tabIndex: 1,
    ),
    HomeServiceItem(
      title: 'Notifications',
      subtitle: 'Stay updated on shipment changes.',
      icon: IconsaxPlusLinear.notification_status,
      route: AppRouter.notifications,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final layoutProvider = context.read<LayoutProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            const HomeGreetingSection()
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 8),
            QuickTrackCard(
                  onTrackTap: () {
                    layoutProvider.setIndex(1);
                  },
                )
                .animate()
                .fadeIn(delay: 100.ms)
                .slideY(begin: 0.05, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 24),
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
            const SizedBox(height: 24),
            RecentUpdateCard(
              onTap: () {
                layoutProvider.setIndex(1);
              },
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
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
