import 'package:injectable/injectable.dart';
import '../repositories/notifications_repository.dart';

@injectable
class MarkAllNotificationsAsReadUseCase {
  final NotificationsRepository _repository;

  MarkAllNotificationsAsReadUseCase(this._repository);

  Future<void> call(String userId) async {
    return await _repository.markAllAsRead(userId);
  }
}
