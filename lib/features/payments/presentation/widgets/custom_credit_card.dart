import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomCreditCard extends StatelessWidget {
  final String cardHolder;
  final String cardNumber;
  final String expiry;

  const CustomCreditCard({
    super.key,
    required this.cardHolder,
    required this.cardNumber,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 180),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2D3235), AppColors.cardBackground],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern or subtle shine
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "E-CUSTOMS OFFICIAL",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Icon(
                      Icons.shield_outlined,
                      color: Colors.white54,
                      size: 24,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Chip icon or mockup
                    Container(
                      width: 45,
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColors.cardChip.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.cardChip,
                            AppColors.cardChip.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      cardNumber.isEmpty
                          ? "••••   ••••   ••••   ••••"
                          : _formatCardNumber(cardNumber),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoColumn(
                      "CARD HOLDER",
                      cardHolder.isEmpty
                          ? "JOHN DOE"
                          : cardHolder.toUpperCase(),
                    ),
                    _buildInfoColumn(
                      "EXPIRES",
                      expiry.isEmpty ? "MM/YY" : expiry,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatCardNumber(String number) {
    String cleanNumber = number.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    List<String> chunks = [];
    for (var i = 0; i < cleanNumber.length; i += 4) {
      chunks.add(
        cleanNumber.substring(
          i,
          i + 4 > cleanNumber.length ? cleanNumber.length : i + 4,
        ),
      );
    }
    return chunks.join('  ');
  }
}
