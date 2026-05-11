import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/firebase_services.dart';
import '../../domain/entities/payment_result_entity.dart';

abstract interface class PaymentRemoteDataSource {
  Future<PaymentResultEntity> completePayment({
    required String userId,
    required String declarationId,
  });
}

@LazySingleton(as: PaymentRemoteDataSource)
class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final FirebaseServices _firebaseServices;
  const PaymentRemoteDataSourceImpl(this._firebaseServices);

  CollectionReference<Map<String, dynamic>> _declarationsRef(String userId) =>
      _firebaseServices.firestore
          .collection('users')
          .doc(userId)
          .collection('declarations');

  @override
  Future<PaymentResultEntity> completePayment({
    required String userId,
    required String declarationId,
  }) async {
    // 1. Fetch user to get passportId
    final userDoc =
        await _firebaseServices.firestore.collection('users').doc(userId).get();

    if (!userDoc.exists) {
      throw Exception('User profile not found');
    }

    final userData = userDoc.data()!;
    final passportId = userData['passportId'] as String?;

    if (passportId == null || passportId.trim().isEmpty) {
      throw Exception(
        'Passport ID is required to complete payment and generate QR. Please update your profile.',
      );
    }

    // 2. Fetch declaration
    final docRef = _declarationsRef(userId).doc(declarationId);
    final doc = await docRef.get();

    if (!doc.exists) {
      throw Exception('Declaration not found');
    }

    final data = doc.data()!;
    final status = data['status'] as String?;

    // 3. Validate status
    if (status != AppConstants.statusCalculated) {
      throw Exception('Declaration must be calculated before payment');
    }

    final double totalAmount = (data['totalAmount'] as num?)?.toDouble() ?? 0.0;
    final DateTime now = DateTime.now();

    // 4. Generate QR Data
    final qrMap = {
      'declarationId': declarationId,
      'passportId': passportId,
      'totalAmount': totalAmount,
      'status': AppConstants.statusPaid,
      'timestamp': now.toIso8601String(),
    };
    final String qrData = jsonEncode(qrMap);

    // 5. Update Firestore
    final updateData = {
      'status': AppConstants.statusPaid,
      'qrData': qrData,
      'paidAt': FieldValue.serverTimestamp(),
    };

    await docRef.update(updateData);

    // 5. Return Entity
    return PaymentResultEntity(
      declarationId: declarationId,
      totalAmount: totalAmount,
      status: AppConstants.statusPaid,
      qrData: qrData,
      paidAt: now,
    );
  }
}
