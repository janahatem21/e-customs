import '../entities/notification_entity.dart';

abstract interface class NotificationsRepository {
  Future<List<NotificationEntity>> getNotifications(String userId);
  Future<void> markAllAsRead(String userId);
  Future<void> markAsRead(String userId, String notificationId);
  Future<int> getUnreadCount(String userId);
}
