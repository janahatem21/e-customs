import 'package:injectable/injectable.dart';
import '../repositories/notifications_repository.dart';

@injectable
class MarkNotificationAsReadUseCase {
  final NotificationsRepository _repository;

  MarkNotificationAsReadUseCase(this._repository);

  Future<void> call(String userId, String notificationId) async {
    return await _repository.markAsRead(userId, notificationId);
  }
}
