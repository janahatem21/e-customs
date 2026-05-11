import '../../../customs/data/models/declaration_model.dart';
import '../../../customs/data/models/item_model.dart';

abstract interface class HistoryRemoteDataSource {
  Future<List<DeclarationModel>> getDeclarations(String userId);

  Future<DeclarationModel?> getDeclarationDetails({
    required String userId,
    required String declarationId,
  });

  Future<List<ItemModel>> getDeclarationItems({
    required String userId,
    required String declarationId,
  });
}
