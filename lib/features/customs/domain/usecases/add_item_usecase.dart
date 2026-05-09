import 'package:injectable/injectable.dart';
import '../entities/item_entity.dart';
import '../repositories/items_repository.dart';

@injectable
class AddItemsUseCase {
  final ItemsRepository _repository;
  const AddItemsUseCase(this._repository);

  Future<void> call(AddItemsParams params) async {
    return await _repository.addItems(
      userId: params.userId,
      declarationId: params.declarationId,
      items: params.items,
    );
  }
}

class AddItemsParams {
  final String userId;
  final String declarationId;
  final List<ItemEntity> items;

  AddItemsParams({
    required this.userId,
    required this.declarationId,
    required this.items,
  });
}
