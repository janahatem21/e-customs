import 'package:e_customs/features/home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../documents/screens/upload_documents_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../payments/screens/fees_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../tracking/presentation/providers/tracking_provider.dart';
import '../../tracking/presentation/screens/track_shipment_screen.dart';
import '../providers/layout_provider.dart';
import '../widgets/bottom_nav.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  static final List<Widget> _tabs = [
    ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const HomeScreen(),
    ),
    ChangeNotifierProvider(
      create: (_) => TrackingProvider(),
      child: const TrackShipmentScreen(),
    ),
    const UploadDocumentsScreen(),
    const FeesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, layoutProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Image.asset(AppAssets.logo, height: 40),
            actions: [
              IconButton(
                padding: const EdgeInsets.only(right: 16),
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.notifications);
                },
                icon: const Icon(
                  IconsaxPlusLinear.notification,
                  color: AppColors.blackText,
                  size: 24,
                ),
              ),
            ],
          ),
          body: _tabs[layoutProvider.currentIndex],
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }
}
