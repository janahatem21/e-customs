import 'package:injectable/injectable.dart';
import '../entities/declaration_entity.dart';
import '../repositories/declarations_repository.dart';

@injectable
class GetDeclarationByIdUseCase {
  final DeclarationsRepository _repository;

  const GetDeclarationByIdUseCase(this._repository);

  Future<DeclarationEntity?> call(String userId, String declarationId) async {
    return await _repository.getDeclarationById(userId, declarationId);
  }
}
