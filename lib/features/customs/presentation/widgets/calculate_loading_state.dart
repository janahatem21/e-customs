import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../data/models/declaration_model.dart';
import '../../domain/entities/item_entity.dart';
import 'calculate_summary_card.dart';
import 'calculate_breakdown_section.dart';
import 'calculate_trust_indicator.dart';

class CalculateLoadingState extends StatelessWidget {
  const CalculateLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for skeleton display
    final mockDeclaration = DeclarationModel(
      status: 'draft',
      totalCustoms: 0.0,
      totalVAT: 0.0,
      totalAmount: 0.0,
    );

    final mockItems = List.generate(
      3,
      (index) => ItemEntity(
        id: index.toString(),
        name: 'Item Name Placeholder',
        category: 'Category',
        price: 0.0,
        quantity: 1,
        currency: 'USD',
        isExempted: false,
      ),
    );

    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalculateSummaryCard(declaration: mockDeclaration, itemCount: 3),
            const SizedBox(height: 24),
            CalculateBreakdownSection(items: mockItems),
            const SizedBox(height: 32),
            const CalculateTrustIndicator(),
          ],
        ),
      ),
    );
  }
}
