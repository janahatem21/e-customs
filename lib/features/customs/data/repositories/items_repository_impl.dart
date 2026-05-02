import 'package:injectable/injectable.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/repositories/items_repository.dart';
import '../datasources/items_remote_data_source.dart';
import '../models/item_model.dart';

@Injectable(as: ItemsRepository)
class ItemsRepositoryImpl implements ItemsRepository {
  final ItemsRemoteDataSource _remoteDataSource;
  const ItemsRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> addItem({
    required String userId,
    required String declarationId,
    required ItemEntity item,
  }) async {
    final itemModel = ItemModel.fromEntity(item);
    await _remoteDataSource.addItem(
      userId: userId,
      declarationId: declarationId,
      item: itemModel,
    );
  }
}
