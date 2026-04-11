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

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
            child: Consumer<NotificationProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const NotificationSkeletonLoading();
                }

                if (provider.notifications.isEmpty) {
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
                          if (provider.unreadCount > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: 0.05,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.lightGrey),
                              ),
                              child: Text(
                                '${provider.unreadCount} Unread',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppColors.subtitleColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
                    ),
                    
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          // Trigger reload if we had an API
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 24),
                          itemCount: provider.notifications.length,
                          itemBuilder: (context, index) {
                            final notification = provider.notifications[index];
                            return NotificationItem(
                              key: ValueKey(notification.id),
                              notification: notification,
                              onTap: () => provider.markAsRead(notification.id),
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
        ],
      ),
    );
  }
}
