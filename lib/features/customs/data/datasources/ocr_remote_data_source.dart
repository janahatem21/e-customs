import 'package:injectable/injectable.dart';
import '../../../../core/services/ocr_service.dart';
import '../models/ocr_item_model.dart';

abstract interface class OcrRemoteDataSource {
  Future<List<OcrItemModel>> scanInvoice(String imagePath);
}

@LazySingleton(as: OcrRemoteDataSource)
class OcrRemoteDataSourceImpl implements OcrRemoteDataSource {
  final OcrService _ocrService;
  const OcrRemoteDataSourceImpl(this._ocrService);

  @override
  Future<List<OcrItemModel>> scanInvoice(String imagePath) async {
    return await _ocrService.extractItemsFromImage(imagePath);
  }
}
