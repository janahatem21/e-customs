import 'package:injectable/injectable.dart';
import '../../domain/entities/payment_result_entity.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';

@Injectable(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource _remoteDataSource;

  const PaymentRepositoryImpl(this._remoteDataSource);

  @override
  Future<PaymentResultEntity> completePayment({
    required String userId,
    required String declarationId,
  }) async {
    return await _remoteDataSource.completePayment(
      userId: userId,
      declarationId: declarationId,
    );
  }
}
