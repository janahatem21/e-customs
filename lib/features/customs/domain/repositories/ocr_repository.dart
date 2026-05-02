import '../entities/ocr_item_entity.dart';

abstract interface class OcrRepository {
  Future<List<OcrItemEntity>> scanInvoice(String imagePath);
}
