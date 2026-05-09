import 'package:injectable/injectable.dart';
import '../../../customs/domain/entities/declaration_entity.dart';
import '../repositories/history_repository.dart';

@injectable
class GetDeclarationsUseCase {
  final HistoryRepository _repository;

  GetDeclarationsUseCase(this._repository);

  Future<List<DeclarationEntity>> call(String userId) {
    return _repository.getDeclarations(userId);
  }
}
