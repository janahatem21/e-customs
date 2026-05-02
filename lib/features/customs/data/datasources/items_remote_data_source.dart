import 'package:injectable/injectable.dart';
import '../../../../core/services/firebase_services.dart';
import '../models/item_model.dart';

abstract interface class ItemsRemoteDataSource {
  Future<void> addItem({
    required String userId,
    required String declarationId,
    required ItemModel item,
  });
}

@LazySingleton(as: ItemsRemoteDataSource)
class ItemsRemoteDataSourceImpl implements ItemsRemoteDataSource {
  final FirebaseServices _firebaseServices;
  const ItemsRemoteDataSourceImpl(this._firebaseServices);

  @override
  Future<void> addItem({
    required String userId,
    required String declarationId,
    required ItemModel item,
  }) async {
    await _firebaseServices.firestore
        .collection('users')
        .doc(userId)
        .collection('declarations')
        .doc(declarationId)
        .collection('items')
        .add(item.toJson());
  }
}
