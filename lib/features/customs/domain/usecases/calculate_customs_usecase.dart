import 'package:injectable/injectable.dart';
import '../repositories/customs_repository.dart';

@injectable
class CalculateCustomsUseCase {
  final CustomsRepository repository;
  const CalculateCustomsUseCase(this.repository);

  Future<void> call({
    required String userId,
    required String declarationId,
  }) async {
    return await repository.calculateCustoms(
      userId: userId,
      declarationId: declarationId,
    );
  }
}
