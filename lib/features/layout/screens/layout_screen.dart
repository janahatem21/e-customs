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
import '../../notifications/presentation/providers/notification_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../widgets/bottom_nav.dart';
import 'package:e_customs/core/di/service_locator.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<UserProvider>().user?.id;
      if (userId != null) {
        context.read<NotificationsProvider>().loadNotifications(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, layoutProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Image.asset(AppAssets.logo, height: 40),
            actions: [
              Stack(
                alignment: Alignment.center,
                children: [
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
                  Selector<NotificationsProvider, int>(
                    selector: (_, p) => p.unreadCount,
                    builder: (context, unreadCount, _) {
                      if (unreadCount == 0) return const SizedBox.shrink();
                      return Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$unreadCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
