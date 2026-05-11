import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/declaration_entity.dart';

class DeclarationModel extends DeclarationEntity {
  const DeclarationModel({
    super.id,
    required super.status,
    required super.totalCustoms,
    required super.totalVAT,
    required super.totalAmount,
    super.createdAt,
    super.qrData,
    super.paidAt,
  });

  factory DeclarationModel.fromJson(Map<String, dynamic> json, String id) {
    return DeclarationModel(
      id: id,
      status: json['status'] ?? 'draft',
      totalCustoms: (json['totalCustoms'] ?? 0).toDouble(),
      totalVAT: (json['totalVAT'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      createdAt:
          json['createdAt'] != null
              ? (json['createdAt'] as Timestamp).toDate()
              : null,
      qrData: json['qrData'] as String?,
      paidAt:
          json['paidAt'] != null
              ? (json['paidAt'] as Timestamp).toDate()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalCustoms': totalCustoms,
      'totalVAT': totalVAT,
      'totalAmount': totalAmount,
      'createdAt':
          createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp(),
      'qrData': qrData,
      'paidAt': paidAt != null ? Timestamp.fromDate(paidAt!) : null,
    };
  }

  factory DeclarationModel.fromEntity(DeclarationEntity entity) {
    return DeclarationModel(
      id: entity.id,
      status: entity.status,
      totalCustoms: entity.totalCustoms,
      totalVAT: entity.totalVAT,
      totalAmount: entity.totalAmount,
      createdAt: entity.createdAt,
      qrData: entity.qrData,
      paidAt: entity.paidAt,
    );
  }
}
