import 'package:injectable/injectable.dart';
import '../entities/notification_entity.dart';
import '../repositories/notifications_repository.dart';

@injectable
class GetNotificationsUseCase {
  final NotificationsRepository _repository;

  GetNotificationsUseCase(this._repository);

  Stream<List<NotificationEntity>> call(String userId) {
    return _repository.getNotifications(userId);
  }
}
