import 'package:injectable/injectable.dart';
import '../entities/notification_entity.dart';
import '../repositories/notifications_repository.dart';

@injectable
class GetNotificationsUseCase {
  final NotificationsRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<List<NotificationEntity>> call(String userId) async {
    return await _repository.getNotifications(userId);
  }
}
