import 'package:injectable/injectable.dart';
import '../../../../core/services/firebase_services.dart';
import '../models/notification_model.dart';

abstract interface class NotificationsRemoteDataSource {
  Stream<List<NotificationModel>> getNotifications(String userId);
  Future<void> markAllAsRead(String userId);
  Future<void> markAsRead(String userId, String notificationId);
  Stream<int> getUnreadCount(String userId);
}

@LazySingleton(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final FirebaseServices _firebaseServices;
  const NotificationsRemoteDataSourceImpl(this._firebaseServices);

  @override
  Stream<List<NotificationModel>> getNotifications(String userId) {
    return _firebaseServices.firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => NotificationModel.fromJson(doc.data(), doc.id))
                  .toList(),
        );
  }

  @override
  Stream<int> getUnreadCount(String userId) {
    return _firebaseServices.firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.size);
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
