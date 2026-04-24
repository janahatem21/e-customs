import 'package:injectable/injectable.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../../../core/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> login(String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<void> logout();
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserModel> register(String name, String email, String password) {
    return _remoteDataSource.register(name, email, password);
  }

  @override
  Future<UserModel> login(String email, String password) {
    return _remoteDataSource.login(email, password);
  }

  @override
  Future<UserModel> signInWithGoogle() {
    return _remoteDataSource.signInWithGoogle();
  }

  @override
  Future<void> logout() {
    return _remoteDataSource.logout();
  }
}
