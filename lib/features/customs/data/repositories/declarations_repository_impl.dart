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
  Future<DeclarationEntity?> getDeclarationById(
    String userId,
    String declarationId,
  ) async {
    return await _remoteDataSource.getDeclarationById(userId, declarationId);
  }

  @override
  Future<void> updateDeclarationStatus(
    String userId,
    String declarationId,
    String status,
  ) async {
    await _remoteDataSource.updateDeclarationStatus(
      userId,
      declarationId,
      status,
    );
  }

  @override
  Future<String> createDeclaration(String userId) async {
    return await _remoteDataSource.createDeclaration(userId);
  }

  @override
  Future<DeclarationEntity?> getLatestCalculatedDeclaration(
    String userId,
  ) async {
    return await _remoteDataSource.getLatestCalculatedDeclaration(userId);
  }
}
