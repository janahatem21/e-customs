import '../entities/declaration_entity.dart';

abstract interface class DeclarationsRepository {
  Future<DeclarationEntity?> getActiveDeclaration(String userId);
  Future<String> createDeclaration(String userId);
}
