import 'package:injectable/injectable.dart';
import '../../../../core/services/firebase_services.dart';
import '../models/item_model.dart';

abstract interface class ItemsRemoteDataSource {
  Future<void> addItem({
    required String userId,
    required String declarationId,
    required ItemModel item,
  });

  Future<void> addItems({
    required String userId,
    required String declarationId,
    required List<ItemModel> items,
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

  @override
  Future<void> addItems({
    required String userId,
    required String declarationId,
    required List<ItemModel> items,
  }) async {
    final batch = _firebaseServices.firestore.batch();
    final collection = _firebaseServices.firestore
        .collection('users')
        .doc(userId)
        .collection('declarations')
        .doc(declarationId)
        .collection('items');

    for (final item in items) {
      final docRef = collection.doc();
      batch.set(docRef, item.toJson());
    }

    await batch.commit();
  }
}
