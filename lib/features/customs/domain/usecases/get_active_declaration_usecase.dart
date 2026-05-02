import 'package:injectable/injectable.dart';
import '../entities/declaration_entity.dart';
import '../repositories/declarations_repository.dart';

@injectable
class GetActiveDeclarationUseCase {
  final DeclarationsRepository _repository;
  const GetActiveDeclarationUseCase(this._repository);

  Future<DeclarationEntity?> call(String userId) async {
    return await _repository.getActiveDeclaration(userId);
  }
}
