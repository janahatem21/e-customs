import 'package:injectable/injectable.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_data_source.dart';

@Injectable(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource _remoteDataSource;

  NotificationsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<NotificationEntity>> getNotifications(String userId) async {
    return await _remoteDataSource.getNotifications(userId);
  }

  @override
  Future<int> getUnreadCount(String userId) async {
    return await _remoteDataSource.getUnreadCount(userId);
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    return await _remoteDataSource.markAllAsRead(userId);
  }

  @override
  Future<void> markAsRead(String userId, String notificationId) async {
    return await _remoteDataSource.markAsRead(userId, notificationId);
  }
}
