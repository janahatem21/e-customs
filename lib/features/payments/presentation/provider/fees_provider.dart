import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/fee_entity.dart';

@injectable
class FeesProvider extends ChangeNotifier {
  final String _shipmentId = "EC-99283-B";
  final double _totalAmount = 1245.50;
  final String _currency = "EUR";
  final String _invoiceNumber = "INV-2024-001";
  final double _declaredValue = 12455.00;

  final List<FeeEntity> _breakdown = [
    FeeEntity(
      title: "Import Duty",
      description: "Category: Electronics (5% of declared value)",
      amount: 622.75,
      icon: Icons.balance_rounded,
    ),
    FeeEntity(
      title: "Value Added Tax (VAT)",
      description: "Standard rate applied (20%)",
      amount: 498.20,
      icon: Icons.percent_rounded,
    ),
    FeeEntity(
      title: "Admin & Processing",
      description: "Customs handling & document verification",
      amount: 124.55,
      icon: Icons.assignment_outlined,
    ),
  ];

  String get shipmentId => _shipmentId;
  double get totalAmount => _totalAmount;
  String get currency => _currency;
  String get invoiceNumber => _invoiceNumber;
  double get declaredValue => _declaredValue;
  List<FeeEntity> get breakdown => _breakdown;

  void processPayment() {
    // Implement payment logic
  }
}
