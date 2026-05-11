import 'package:injectable/injectable.dart';
import '../entities/declaration_entity.dart';
import '../repositories/declarations_repository.dart';

@injectable
class GetLatestCalculatedDeclarationUseCase {
  final DeclarationsRepository _repository;
  const GetLatestCalculatedDeclarationUseCase(this._repository);

  Future<DeclarationEntity?> call(String userId) async {
    return await _repository.getLatestCalculatedDeclaration(userId);
  }
}
