import 'package:injectable/injectable.dart';
import '../entities/ocr_item_entity.dart';
import '../repositories/ocr_repository.dart';

@injectable
class ScanInvoiceUseCase {
  final OcrRepository _repository;
  const ScanInvoiceUseCase(this._repository);

  Future<List<OcrItemEntity>> call(String imagePath) async {
    return await _repository.scanInvoice(imagePath);
  }
}
