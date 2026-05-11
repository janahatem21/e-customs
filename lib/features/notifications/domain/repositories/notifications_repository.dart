import '../entities/notification_entity.dart';

abstract interface class NotificationsRepository {
  Stream<List<NotificationEntity>> getNotifications(String userId);
  Future<void> markAllAsRead(String userId);
  Future<void> markAsRead(String userId, String notificationId);
  Stream<int> getUnreadCount(String userId);
}
