class OcrItemEntity {
  final String name;
  final double price;
  final String? category;
  final String? currency;
  final int quantity;

  const OcrItemEntity({
    required this.name,
    required this.price,
    this.category,
    this.currency,
    this.quantity = 1,
  });

  OcrItemEntity copyWith({
    String? name,
    double? price,
    String? category,
    String? currency,
    int? quantity,
  }) {
    return OcrItemEntity(
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      currency: currency ?? this.currency,
      quantity: quantity ?? this.quantity,
    );
  }
}
