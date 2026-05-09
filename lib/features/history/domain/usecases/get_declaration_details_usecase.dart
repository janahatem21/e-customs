import 'package:injectable/injectable.dart';
import '../../../customs/domain/entities/declaration_entity.dart';
import '../repositories/history_repository.dart';

@injectable
class GetDeclarationDetailsUseCase {
  final HistoryRepository _repository;

  GetDeclarationDetailsUseCase(this._repository);

  Future<DeclarationEntity?> call({
    required String userId,
    required String declarationId,
  }) {
    return _repository.getDeclarationDetails(
      userId: userId,
      declarationId: declarationId,
    );
  }
}
