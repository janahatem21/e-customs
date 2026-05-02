import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/firebase_services.dart';
import '../models/declaration_model.dart';

abstract interface class DeclarationsRemoteDataSource {
  Future<DeclarationModel?> getActiveDeclaration(String userId);
  Future<String> createDeclaration(String userId);
}

@LazySingleton(as: DeclarationsRemoteDataSource)
class DeclarationsRemoteDataSourceImpl implements DeclarationsRemoteDataSource {
  final FirebaseServices _firebaseServices;
  const DeclarationsRemoteDataSourceImpl(this._firebaseServices);

  CollectionReference<Map<String, dynamic>> _declarationsRef(String userId) =>
      _firebaseServices.firestore
          .collection('users')
          .doc(userId)
          .collection('declarations');

  @override
  Future<DeclarationModel?> getActiveDeclaration(String userId) async {
    final snapshot =
        await _declarationsRef(
          userId,
        ).where('status', isEqualTo: 'draft').limit(1).get();

    if (snapshot.docs.isNotEmpty) {
      return DeclarationModel.fromJson(
        snapshot.docs.first.data(),
        snapshot.docs.first.id,
      );
    }
    return null;
  }

  @override
  Future<String> createDeclaration(String userId) async {
    // 1. Check if there is already a draft declaration
    final active = await getActiveDeclaration(userId);
    if (active != null) {
      return active.id!;
    }

    // 2. If not, create a new one
    const model = DeclarationModel(
      status: 'draft',
      totalCustoms: 0.0,
      totalVAT: 0.0,
      totalAmount: 0.0,
    );
    final docRef = await _declarationsRef(userId).add(model.toJson());

    return docRef.id;
  }
}
