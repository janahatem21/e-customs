import 'package:injectable/injectable.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_data_source.dart';

@Injectable(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource _remoteDataSource;

  NotificationsRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<NotificationEntity>> getNotifications(String userId) {
    return _remoteDataSource.getNotifications(userId);
  }

  @override
  Stream<int> getUnreadCount(String userId) {
    return _remoteDataSource.getUnreadCount(userId);
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
