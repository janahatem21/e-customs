import '../entities/payment_result_entity.dart';

abstract interface class PaymentRepository {
  Future<PaymentResultEntity> completePayment({
    required String userId,
    required String declarationId,
  });
}
