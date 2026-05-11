import 'package:injectable/injectable.dart';
import '../repositories/declarations_repository.dart';

@injectable
class CreateDeclarationUseCase {
  final DeclarationsRepository _repository;
  const CreateDeclarationUseCase(this._repository);

  Future<String> call(String userId) async {
    return await _repository.createDeclaration(userId);
  }
}
