import 'package:injectable/injectable.dart';
import '../entities/item_entity.dart';
import '../repositories/customs_repository.dart';

@injectable
class GetItemsUseCase {
  final CustomsRepository _repository;

  GetItemsUseCase(this._repository);

  Future<List<ItemEntity>> call({
    required String userId,
    required String declarationId,
  }) async {
    return await _repository.getItems(
      userId: userId,
      declarationId: declarationId,
    );
  }
}
