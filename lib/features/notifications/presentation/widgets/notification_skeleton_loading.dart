import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:e_customs/features/notifications/data/entities/notification_entity.dart';
import 'package:e_customs/features/notifications/presentation/widgets/notification_item.dart';

class NotificationSkeletonLoading extends StatelessWidget {
  const NotificationSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        itemBuilder: (context, index) {
          return NotificationItem(
            notification: NotificationEntity(
              id: 'skeleton-$index',
              title: 'Loading Title Text',
              body: 'This is a skeleton loading shimmer effect for the notification body text.',
              timestamp: DateTime.now(),
              type: NotificationType.shipment,
              isRead: true,
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
