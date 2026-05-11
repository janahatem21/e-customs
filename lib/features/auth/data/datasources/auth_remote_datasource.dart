import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/services/firebase_services.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> login(String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> logout();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseServices _firebaseServices;

  AuthRemoteDataSourceImpl(this._firebaseServices);

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final userCredential = await _firebaseServices.auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('User creation failed');
      }

      final userModel = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      await _firebaseServices.firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toFirestore());

      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await _firebaseServices.auth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('Login failed');
      }

      final doc =
          await _firebaseServices.firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();

      if (!doc.exists) {
        throw Exception('User data not found');
      }

      return UserModel.fromFirestore(doc.data()!, doc.id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseServices.auth.signInWithCredential(
        credential,
      );

      if (userCredential.user == null) {
        throw Exception('Google Sign-In failed');
      }

      final doc =
          await _firebaseServices.firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();

      if (doc.exists) {
        return UserModel.fromFirestore(doc.data()!, doc.id);
      } else {
        // Create new user in Firestore if not exists
        final userModel = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? 'Google User',
          email: userCredential.user!.email ?? '',
          createdAt: DateTime.now(),
        );

        await _firebaseServices.firestore
            .collection('users')
            .doc(userModel.id)
            .set(userModel.toFirestore());

        return userModel;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseServices.auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseServices.auth.signOut();
    await GoogleSignIn.instance.signOut();
  }
}
