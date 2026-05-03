import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/firebase_services.dart';
import '../models/declaration_model.dart';
import '../models/item_model.dart';

abstract interface class CustomsRemoteDataSource {
  Future<List<ItemModel>> getItems({
    required String userId,
    required String declarationId,
  });

  Future<void> updateDeclaration({
    required String userId,
    required String declarationId,
    required DeclarationModel declaration,
  });
}

@Injectable(as: CustomsRemoteDataSource)
class CustomsRemoteDataSourceImpl implements CustomsRemoteDataSource {
  final FirebaseServices _firebaseServices;
  const CustomsRemoteDataSourceImpl(this._firebaseServices);

  CollectionReference<Map<String, dynamic>> _itemsRef(
    String userId,
    String declarationId,
  ) => _firebaseServices.firestore
      .collection('users')
      .doc(userId)
      .collection('declarations')
      .doc(declarationId)
      .collection('items');

  DocumentReference<Map<String, dynamic>> _declarationRef(
    String userId,
    String declarationId,
  ) => _firebaseServices.firestore
      .collection('users')
      .doc(userId)
      .collection('declarations')
      .doc(declarationId);

  @override
  Future<List<ItemModel>> getItems({
    required String userId,
    required String declarationId,
  }) async {
    final snapshot = await _itemsRef(userId, declarationId).get();
    return snapshot.docs
        .map((doc) => ItemModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> updateDeclaration({
    required String userId,
    required String declarationId,
    required DeclarationModel declaration,
  }) async {
    await _declarationRef(userId, declarationId).update(declaration.toJson());
  }
}
