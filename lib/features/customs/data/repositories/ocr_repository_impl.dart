import 'package:injectable/injectable.dart';
import '../../domain/entities/ocr_item_entity.dart';
import '../../domain/repositories/ocr_repository.dart';
import '../datasources/ocr_remote_data_source.dart';

@LazySingleton(as: OcrRepository)
class OcrRepositoryImpl implements OcrRepository {
  final OcrRemoteDataSource _remoteDataSource;
  const OcrRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<OcrItemEntity>> scanInvoice(String imagePath) async {
    final models = await _remoteDataSource.scanInvoice(imagePath);
    return models.map((m) => m.toEntity()).toList();
  }
}
