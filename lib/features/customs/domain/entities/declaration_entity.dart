class DeclarationEntity {
  final String? id;
  final String status;
  final double totalCustoms;
  final double totalVAT;
  final double totalAmount;
  final DateTime? createdAt;

  final String? qrData;
  final DateTime? paidAt;

  const DeclarationEntity({
    this.id,
    required this.status,
    required this.totalCustoms,
    required this.totalVAT,
    required this.totalAmount,
    this.createdAt,
    this.qrData,
    this.paidAt,
  });
}
