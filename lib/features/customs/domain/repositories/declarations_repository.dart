import '../entities/declaration_entity.dart';

abstract interface class DeclarationsRepository {
  Future<DeclarationEntity?> getActiveDeclaration(String userId);
  Future<DeclarationEntity?> getDeclarationById(
    String userId,
    String declarationId,
  );
  Future<void> updateDeclarationStatus(
    String userId,
    String declarationId,
    String status,
  );
  Future<String> createDeclaration(String userId);
  Future<DeclarationEntity?> getLatestCalculatedDeclaration(String userId);
}
