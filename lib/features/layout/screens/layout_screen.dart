import 'package:e_customs/features/home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../home/screens/home_screen.dart';
import '../../profile/presentation/screens/profile_screen.dart';
import '../../profile/presentation/provider/profile_provider.dart';
import '../../history/presentation/screens/history_screen.dart';
import '../../history/presentation/provider/history_provider.dart';
import '../providers/layout_provider.dart';
import '../widgets/bottom_nav.dart';
import 'package:e_customs/core/di/service_locator.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  static final List<Widget> _tabs = [
    ChangeNotifierProvider(
      create: (_) => getIt<HomeProvider>(),
      child: const HomeScreen(),
    ),
    ChangeNotifierProvider(
      create: (_) => getIt<HistoryProvider>(),
      child: const HistoryScreen(),
    ),
    ChangeNotifierProvider(
      create: (_) => getIt<ProfileProvider>(),
      child: const ProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, layoutProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Image.asset(AppAssets.logo, height: 40),
            actions: [
              IconButton(
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
