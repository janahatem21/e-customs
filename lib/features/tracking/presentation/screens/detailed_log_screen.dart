import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../providers/tracking_provider.dart';

class DetailedLogScreen extends StatelessWidget {
  const DetailedLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Detailed History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.blackText,
            letterSpacing: 0.5,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            IconsaxPlusLinear.arrow_left_1,
            color: AppColors.blackText,
            size: 24,
          ),
        ),
      ),
      body: Consumer<TrackingProvider>(
        builder: (context, provider, child) {
          final shipment = provider.currentShipment;
          if (shipment == null) {
            return const Center(child: Text('No data found'));
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              // Header ID Card
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        IconsaxPlusBold.box_tick,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TRACKING NUMBER',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.subtitleColor,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          shipment.trackingNumber,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.blackText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),

              const SizedBox(height: 32),

              Row(
                children: [
                  const Text(
                    'Activity Log',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.blackText,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${shipment.steps.length} ENTRIES',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.subtitleColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 100.ms),

              const SizedBox(height: 20),

              // Log Entries
              ...List.generate(shipment.steps.length, (index) {
                final step = shipment.steps[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  step.date.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  step.time,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.subtitleColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              step.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.blackText,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              step.details,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.blackText.withValues(
                                  alpha: 0.7,
                                ),
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              height: 1,
                              color: AppColors.lightGrey,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  IconsaxPlusLinear.location,
                                  size: 16,
                                  color: AppColors.subtitleColor,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    step.location,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.subtitleColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: Duration(milliseconds: 150 * index + 200))
                      .slideY(begin: 0.1, end: 0),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
