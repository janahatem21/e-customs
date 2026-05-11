import 'package:injectable/injectable.dart';
import '../../../customs/domain/entities/item_entity.dart';
import '../repositories/history_repository.dart';

@injectable
class GetDeclarationItemsUseCase {
  final HistoryRepository _repository;

  GetDeclarationItemsUseCase(this._repository);

  Future<List<ItemEntity>> call({
    required String userId,
    required String declarationId,
  }) {
    return _repository.getDeclarationItems(
      userId: userId,
      declarationId: declarationId,
    );
  }
}
