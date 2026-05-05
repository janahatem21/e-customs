class PaymentResultEntity {
  final String declarationId;
  final double totalAmount;
  final String status;
  final String qrData;
  final DateTime paidAt;

  const PaymentResultEntity({
    required this.declarationId,
    required this.totalAmount,
    required this.status,
    required this.qrData,
    required this.paidAt,
  });
}
