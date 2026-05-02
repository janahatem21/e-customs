import '../entities/item_entity.dart';

abstract interface class ItemsRepository {
  Future<void> addItem({
    required String userId,
    required String declarationId,
    required ItemEntity item,
  });
}
