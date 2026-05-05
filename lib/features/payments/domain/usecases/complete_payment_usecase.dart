import 'package:injectable/injectable.dart';
import '../entities/payment_result_entity.dart';
import '../repositories/payment_repository.dart';

@injectable
class CompletePaymentUseCase {
  final PaymentRepository _repository;
  const CompletePaymentUseCase(this._repository);

  Future<PaymentResultEntity> call({
    required String userId,
    required String declarationId,
  }) async {
    return await _repository.completePayment(
      userId: userId,
      declarationId: declarationId,
    );
  }
}
