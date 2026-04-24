import 'package:injectable/injectable.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/services/firebase_services.dart';

abstract class ProfileRemoteDataSource {
  Stream<UserModel?> getProfileStream();
  Future<void> updateProfile(UserModel user);
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseServices _firebaseServices;

  ProfileRemoteDataSourceImpl(this._firebaseServices);

  @override
  Stream<UserModel?> getProfileStream() {
    final user = _firebaseServices.auth.currentUser;
    if (user == null) return Stream.value(null);

    return _firebaseServices.firestore
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((doc) {
          if (!doc.exists) return null;
          return UserModel.fromFirestore(doc.data()!, doc.id);
        });
  }

  @override
  Future<void> updateProfile(UserModel user) async {
    await _firebaseServices.firestore
        .collection('users')
        .doc(user.id)
        .update(user.toFirestore());
  }
}
