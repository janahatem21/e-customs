import 'package:injectable/injectable.dart';
import '../repositories/notifications_repository.dart';

@injectable
class GetUnreadNotificationsCountUseCase {
  final NotificationsRepository _repository;

  GetUnreadNotificationsCountUseCase(this._repository);

  Future<int> call(String userId) async {
    return await _repository.getUnreadCount(userId);
  }
}
