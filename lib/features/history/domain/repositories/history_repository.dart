import '../../../customs/domain/entities/declaration_entity.dart';
import '../../../customs/domain/entities/item_entity.dart';

abstract interface class HistoryRepository {
  Future<List<DeclarationEntity>> getDeclarations(String userId);

  Future<DeclarationEntity?> getDeclarationDetails({
    required String userId,
    required String declarationId,
  });

  Future<List<ItemEntity>> getDeclarationItems({
    required String userId,
    required String declarationId,
  });
}
