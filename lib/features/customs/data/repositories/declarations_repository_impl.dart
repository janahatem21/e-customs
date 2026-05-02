import 'package:injectable/injectable.dart';
import '../../domain/entities/declaration_entity.dart';
import '../../domain/repositories/declarations_repository.dart';
import '../datasources/declarations_remote_data_source.dart';

@Injectable(as: DeclarationsRepository)
class DeclarationsRepositoryImpl implements DeclarationsRepository {
  final DeclarationsRemoteDataSource _remoteDataSource;

  const DeclarationsRepositoryImpl(this._remoteDataSource);

  @override
  Future<DeclarationEntity?> getActiveDeclaration(String userId) async {
    return await _remoteDataSource.getActiveDeclaration(userId);
  }

  @override
  Future<String> createDeclaration(String userId) async {
    return await _remoteDataSource.createDeclaration(userId);
  }
}
