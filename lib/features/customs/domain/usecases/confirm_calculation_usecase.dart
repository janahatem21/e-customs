import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../repositories/declarations_repository.dart';

@injectable
class ConfirmCalculationUseCase {
  final DeclarationsRepository _repository;

  const ConfirmCalculationUseCase(this._repository);

  Future<void> call(String userId, String declarationId) async {
    return await _repository.updateDeclarationStatus(
      userId,
      declarationId,
      AppConstants.statusCalculated,
    );
  }
}
