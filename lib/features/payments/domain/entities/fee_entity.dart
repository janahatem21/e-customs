import 'package:flutter/material.dart';

class FeeEntity {
  final String title;
  final String description;
  final double amount;
  final IconData icon;

  FeeEntity({
    required this.title,
    required this.description,
    required this.amount,
    required this.icon,
  });
}
