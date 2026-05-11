import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'fcm_service.dart';
import 'firebase_services.dart';

@lazySingleton
class NotificationService {
  final FirebaseServices _firebaseServices;
  final FCMService _fcmService;

  NotificationService(this._firebaseServices, this._fcmService);

  /// Centralized method to create a Firestore notification and trigger a push notification.
  Future<void> notify({
    required String userId,
    required String title,
    required String body,
    required String type,
    String? declarationId,
  }) async {
    try {
      // 1. Create In-App Notification in Firestore
      await _firebaseServices.firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .add({
        'title': title,
        'body': body,
        'type': type,
        'isRead': false,
        'declarationId': declarationId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 2. Trigger FCM Push Notification (Simulated via Local Notification)
      await _fcmService.showLocalNotification(
        title: title,
        body: body,
        data: declarationId != null ? {'declarationId': declarationId} : null,
      );
    } catch (e) {
      // Error logging can be added here
    }
  }

  // --- Specialized Event Trigger Methods ---

  /// Triggered when OCR items are successfully imported.
  Future<void> notifyOCRImportSuccess(String userId, String declarationId) async {
    await notify(
      userId: userId,
      title: 'Items Imported',
      body: 'Your invoice items were imported successfully.',
      type: 'declaration',
      declarationId: declarationId,
    );
  }

  /// Triggered when customs fees are calculated.
  Future<void> notifyCustomsCalculated(String userId, String declarationId) async {
    await notify(
      userId: userId,
      title: 'Declaration Ready For Payment',
      body: 'Your customs fees have been calculated.',
      type: 'payment',
      declarationId: declarationId,
    );
  }

  /// Triggered when payment is successful.
  Future<void> notifyPaymentSuccess(String userId, String declarationId) async {
    await notify(
      userId: userId,
      title: 'Payment Successful',
      body: 'Your customs payment has been completed successfully.',
      type: 'payment',
      declarationId: declarationId,
    );
  }

  /// Triggered when QR code is generated.
  Future<void> notifyQRReady(String userId, String declarationId) async {
    await notify(
      userId: userId,
      title: 'QR Code Ready',
      body: 'Your airport verification QR code is ready.',
      type: 'payment',
      declarationId: declarationId,
    );
  }
}
