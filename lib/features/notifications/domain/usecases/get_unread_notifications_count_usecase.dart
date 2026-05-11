import 'package:injectable/injectable.dart';
import '../repositories/notifications_repository.dart';

@injectable
class GetUnreadNotificationsCountUseCase {
  final NotificationsRepository _repository;
  const GetUnreadNotificationsCountUseCase(this._repository);

  Stream<int> call(String userId) {
    return _repository.getUnreadCount(userId);
  }
}
