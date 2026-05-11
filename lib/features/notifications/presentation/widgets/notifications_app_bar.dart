import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/features/notifications/presentation/providers/notification_provider.dart';
import 'package:e_customs/core/providers/user_provider.dart';

class NotificationsAppBar extends AppBar {
  NotificationsAppBar({super.key, required BuildContext context})
    : super(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Notifications',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.blackText,
          ),
        ),
        actions: [
          Selector<NotificationsProvider, int>(
            selector: (_, p) => p.unreadCount,
            builder: (context, unreadCount, _) {
              if (unreadCount == 0) return const SizedBox.shrink();
              return TextButton(
                onPressed: () {
                  final userId = context.read<UserProvider>().user?.id;
                  if (userId != null) {
                    context.read<NotificationsProvider>().markAllAsRead(userId);
                  }
                },
                child: const Text('Mark all read'),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      );
}
