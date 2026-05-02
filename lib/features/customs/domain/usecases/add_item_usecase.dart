import 'package:injectable/injectable.dart';
import '../entities/item_entity.dart';
import '../repositories/items_repository.dart';

@injectable
class AddItemUseCase {
  final ItemsRepository _repository;
  const AddItemUseCase(this._repository);

  Future<void> call(AddItemParams params) async {
    return await _repository.addItem(
      userId: params.userId,
      declarationId: params.declarationId,
      item: params.item,
    );
  }
}

class AddItemParams {
  final String userId;
  final String declarationId;
  final ItemEntity item;

  AddItemParams({
    required this.userId,
    required this.declarationId,
    required this.item,
  });
}
