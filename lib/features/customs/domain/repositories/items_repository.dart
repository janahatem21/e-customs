import '../entities/item_entity.dart';

abstract interface class ItemsRepository {
  Future<void> addItem({
    required String userId,
    required String declarationId,
    required ItemEntity item,
  });

  Future<void> addItems({
    required String userId,
    required String declarationId,
    required List<ItemEntity> items,
  });
}
