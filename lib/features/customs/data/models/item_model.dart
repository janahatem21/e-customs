import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    super.id,
    required super.name,
    required super.category,
    required super.price,
    required super.quantity,
    required super.currency,
    super.isExempted = false,
    super.createdAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json, [String? id]) {
    return ItemModel(
      id: id,
      name: json['name'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      currency: json['currency'] as String,
      isExempted: json['isExempted'] as bool? ?? false,
      createdAt: json['createdAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'quantity': quantity,
      'currency': currency,
      'isExempted': isExempted,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  factory ItemModel.fromEntity(ItemEntity entity) {
    return ItemModel(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      price: entity.price,
      quantity: entity.quantity,
      currency: entity.currency,
      isExempted: entity.isExempted,
      createdAt: entity.createdAt,
    );
  }
}
