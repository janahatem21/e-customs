import 'package:e_customs/features/customs/domain/entities/item_entity.dart';

abstract interface class CustomsRepository {
  Future<void> calculateCustoms({
    required String userId,
    required String declarationId,
  });

  Future<List<ItemEntity>> getItems({
    required String userId,
    required String declarationId,
  });
}
