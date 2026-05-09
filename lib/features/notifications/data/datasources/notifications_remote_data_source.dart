import 'package:injectable/injectable.dart';
import '../../../../core/services/firebase_services.dart';
import '../models/notification_model.dart';

abstract interface class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications(String userId);
  Future<void> markAllAsRead(String userId);
  Future<void> markAsRead(String userId, String notificationId);
  Future<int> getUnreadCount(String userId);
}

@LazySingleton(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final FirebaseServices _firebaseServices;
  const NotificationsRemoteDataSourceImpl(this._firebaseServices);

  @override
  Future<List<NotificationModel>> getNotifications(String userId) async {
    final snapshot =
        await _firebaseServices.firestore
            .collection('users')
            .doc(userId)
            .collection('notifications')
            .orderBy('createdAt', descending: true)
            .get();

    return snapshot.docs
        .map((doc) => NotificationModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<int> getUnreadCount(String userId) async {
    final snapshot =
        await _firebaseServices.firestore
            .collection('users')
            .doc(userId)
            .collection('notifications')
            .where('isRead', isEqualTo: false)
            .count()
            .get();

    return snapshot.count ?? 0;
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    final unreadDocs =
        await _firebaseServices.firestore
            .collection('users')
            .doc(userId)
            .collection('notifications')
            .where('isRead', isEqualTo: false)
            .get();

    if (unreadDocs.docs.isEmpty) return;

    final batch = _firebaseServices.firestore.batch();
    for (var doc in unreadDocs.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }

  @override
  Future<void> markAsRead(String userId, String notificationId) async {
    await _firebaseServices.firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }
}
