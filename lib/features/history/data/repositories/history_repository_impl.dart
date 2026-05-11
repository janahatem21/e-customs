import 'package:injectable/injectable.dart';
import '../../../customs/domain/entities/declaration_entity.dart';
import '../../../customs/domain/entities/item_entity.dart';
import '../datasources/history_remote_data_source.dart';
import '../../domain/repositories/history_repository.dart';

@Injectable(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource _remoteDataSource;

  HistoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<DeclarationEntity>> getDeclarations(String userId) async {
    return await _remoteDataSource.getDeclarations(userId);
  }

  @override
  Future<DeclarationEntity?> getDeclarationDetails({
    required String userId,
    required String declarationId,
  }) async {
    return await _remoteDataSource.getDeclarationDetails(
      userId: userId,
      declarationId: declarationId,
    );
  }

  @override
  Future<List<ItemEntity>> getDeclarationItems({
    required String userId,
    required String declarationId,
  }) async {
    return await _remoteDataSource.getDeclarationItems(
      userId: userId,
      declarationId: declarationId,
    );
  }
}
