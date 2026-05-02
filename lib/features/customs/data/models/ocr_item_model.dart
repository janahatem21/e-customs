import '../../domain/entities/ocr_item_entity.dart';

class OcrItemModel extends OcrItemEntity {
  const OcrItemModel({
    required super.name,
    required super.price,
    super.category,
    super.currency,
    super.quantity = 1,
  });

  factory OcrItemModel.fromJson(Map<String, dynamic> json) {
    return OcrItemModel(
      name: json['name'] as String? ?? 'Unknown Item',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      category: json['category'] as String?,
      currency: json['currency'] as String?,
    );
  }

  /// RESTORED: Manual parsing logic as a fallback for AI Quota/Error issues
  factory OcrItemModel.fromTextLine(String line) {
    final trimmedLine = line.trim();
    if (trimmedLine.isEmpty) throw const FormatException('Empty line');

    // Simple RegEx to find the last number as price
    final priceRegex = RegExp(r'(\d+[\.,]\d{2})|(\d+)');
    final matches = priceRegex.allMatches(trimmedLine).toList();

    if (matches.isEmpty) throw const FormatException('No price found');

    final match = matches.last;
    final priceStr = match.group(0)!.replaceAll(',', '.');
    final price = double.tryParse(priceStr) ?? 0.0;

    String name = trimmedLine.substring(0, match.start).trim();
    name = name.replaceAll(RegExp(r'[:\-_]$'), '').trim();
    if (name.isEmpty) name = 'Unknown Item';

    return OcrItemModel(name: name, price: price);
  }

  OcrItemEntity toEntity() => OcrItemEntity(
    name: name,
    price: price,
    category: category,
    currency: currency,
    quantity: quantity,
  );
}
