import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

@lazySingleton
class ImageProcessorService {
  Future<File?> compressImage(String path) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = p.basenameWithoutExtension(path);
    final targetPath = p.join(tempDir.path, 'compressed_$fileName.jpg');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      targetPath,
      quality: 70,
      minWidth: 1024,
      format: CompressFormat.jpeg,
    );

    if (result == null) return null;
    return File(result.path);
  }
}
