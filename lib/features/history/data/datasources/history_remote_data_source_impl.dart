import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/firebase_services.dart';
import '../../../customs/data/models/declaration_model.dart';
import '../../../customs/data/models/item_model.dart';
import 'history_remote_data_source.dart';

@LazySingleton(as: HistoryRemoteDataSource)
class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final FirebaseServices _firebaseServices;
  const HistoryRemoteDataSourceImpl(this._firebaseServices);

  CollectionReference<Map<String, dynamic>> _declarationsRef(String userId) =>
      _firebaseServices.firestore
          .collection('users')
          .doc(userId)
          .collection('declarations');

  @override
  Future<List<DeclarationModel>> getDeclarations(String userId) async {
    final snapshot =
        await _declarationsRef(
          userId,
        ).orderBy('createdAt', descending: true).get();

    return snapshot.docs
        .map((doc) => DeclarationModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<DeclarationModel?> getDeclarationDetails({
    required String userId,
    required String declarationId,
  }) async {
    final doc = await _declarationsRef(userId).doc(declarationId).get();
    if (doc.exists && doc.data() != null) {
      return DeclarationModel.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  @override
  Future<List<ItemModel>> getDeclarationItems({
    required String userId,
    required String declarationId,
  }) async {
    final snapshot =
        await _declarationsRef(
          userId,
        ).doc(declarationId).collection('items').get();

    return snapshot.docs
        .map((doc) => ItemModel.fromJson(doc.data(), doc.id))
        .toList();
  }
}
