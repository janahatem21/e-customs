import 'package:cloud_firestore/cloud_firestore.dart';

class ItemEntity {
  final String? id;
  final String name;
  final String category;
  final double price;
  final int quantity;
  final String currency;
  final bool isExempted;
  final Timestamp? createdAt;

  const ItemEntity({
    this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.currency,
    this.isExempted = false,
    this.createdAt,
  });
}
