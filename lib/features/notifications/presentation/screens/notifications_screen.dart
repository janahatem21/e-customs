import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/features/notifications/presentation/providers/notification_provider.dart';
import 'package:e_customs/features/notifications/presentation/widgets/notification_item.dart';
import 'package:e_customs/features/notifications/presentation/widgets/notifications_app_bar.dart';
import 'package:e_customs/features/notifications/presentation/widgets/filter_tabs_row.dart';
import 'package:e_customs/features/notifications/presentation/widgets/notification_empty_state.dart';
import 'package:e_customs/features/notifications/presentation/widgets/notification_skeleton_loading.dart';

import 'package:e_customs/core/providers/user_provider.dart';
import 'package:e_customs/features/notifications/domain/entities/notification_entity.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: NotificationsAppBar(context: context),
      body: Column(
        children: [
          // Filter Tabs
          const FilterTabsRow()
              .animate()
              .fadeIn(duration: 300.ms)
              .slideX(
                begin: 0.1,
                end: 0,
                duration: 300.ms,
                curve: Curves.easeOutCubic,
              ),

          Expanded(
            child: Selector<NotificationsProvider, bool>(
              selector: (_, p) => p.isLoading,
              builder: (context, isLoading, child) {
                if (isLoading) {
                  return const NotificationSkeletonLoading();
                }
                return child!;
              },
              child: Selector<NotificationsProvider, List<NotificationEntity>>(
                selector: (_, p) => p.notifications,
                builder: (context, notifications, _) {
                  if (notifications.isEmpty) {
                    return const NotificationEmptyState()
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          end: const Offset(1, 1),
                          curve: Curves.easeOutBack,
                        );
                  }

                  return Column(
                    children: [
                      // Alerts Summary Row
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'RECENT ALERTS',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.subtitleColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Selector<NotificationsProvider, int>(
                              selector: (_, p) => p.unreadCount,
                              builder: (context, unreadCount, _) {
                                if (unreadCount == 0)
                                  return const SizedBox.shrink();
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.05,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                  child: Text(
                                    '$unreadCount Unread',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: AppColors.subtitleColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
                      ),

                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            final userId =
                                context.read<UserProvider>().user?.id;
                            if (userId != null) {
                              await context
                                  .read<NotificationsProvider>()
                                  .loadNotifications(userId);
                            }
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 24),
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              final notification = notifications[index];
                              return NotificationItem(
                                key: ValueKey(notification.id),
                                notification: notification,
                                onTap: () {
                                  final userId =
                                      context.read<UserProvider>().user?.id;
                                  if (userId != null) {
                                    context
                                        .read<NotificationsProvider>()
                                        .markAsRead(userId, notification.id);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
