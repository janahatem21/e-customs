import 'package:injectable/injectable.dart';
import '../datasources/profile_remote_datasource.dart';
import '../../../../core/models/user_model.dart';

abstract interface class ProfileRepository {
  Stream<UserModel?> getProfileStream();
  Future<void> updateProfile(UserModel user);
}

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  const ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Stream<UserModel?> getProfileStream() {
    return _remoteDataSource.getProfileStream();
  }

  @override
  Future<void> updateProfile(UserModel user) {
    return _remoteDataSource.updateProfile(user);
  }
}
