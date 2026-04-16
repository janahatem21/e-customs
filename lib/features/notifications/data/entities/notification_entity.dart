import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:e_customs/core/constants/app_colors.dart';

enum NotificationType {
  shipment,
  payments,
  system;

  String get label {
    switch (this) {
      case NotificationType.shipment:
        return 'Shipment';
      case NotificationType.payments:
        return 'Payments';
      case NotificationType.system:
        return 'System';
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.shipment:
        return IconsaxPlusLinear.box;
      case NotificationType.payments:
        return IconsaxPlusLinear.wallet_check;
      case NotificationType.system:
        return IconsaxPlusLinear.setting_2;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.shipment:
        return AppColors.info;
      case NotificationType.payments:
        return AppColors.success;
      case NotificationType.system:
        return AppColors.primary;
    }
  }
}

class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final NotificationType type;
  bool isRead;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });

  static List<NotificationEntity> dummyNotifications = [
    NotificationEntity(
      id: '1',
      title: 'Shipment Delivered',
      body: 'Your package #EC-7721 has been successfully delivered to your doorstep.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      type: NotificationType.shipment,
      isRead: false,
    ),
    NotificationEntity(
      id: '2',
      title: 'Payment Successful',
      body: 'Customs clearance fees for shipment #EC-8002 have been paid.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.payments,
      isRead: true,
    ),
    NotificationEntity(
      id: '3',
      title: 'Action Required',
      body: 'Please upload the commercial invoice for your pending shipment.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.shipment,
      isRead: false,
    ),
    NotificationEntity(
      id: '4',
      title: 'Maintenance Update',
      body: 'The system will be offline for 2 hours on Sunday for scheduled maintenance.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.system,
      isRead: true,
    ),
  ];
}
