import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../providers/tracking_provider.dart';
import '../widgets/tracking_search_bar.dart';
import '../widgets/shipment_info_card.dart';
import '../widgets/tracking_step_item.dart';
import '../widgets/verification_card.dart';
import '../widgets/tracking_skeleton_loading.dart';

class TrackShipmentScreen extends StatelessWidget {
  const TrackShipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Consumer<TrackingProvider>(
          builder: (context, provider, child) {
            return ListView(
              padding: const EdgeInsets.only(bottom: 30),
              children: [
                const TrackingSearchBar()
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: -0.1, end: 0),

                if (provider.isLoading)
                  const TrackingSkeletonLoading()
                else if (provider.currentShipment != null) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: ShipmentInfoCard(shipment: provider.currentShipment!)
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 100.ms)
                        .scale(begin: const Offset(0.95, 0.95)),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Shipment Journey',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.blackText,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            IconsaxPlusLinear.document_text,
                            size: 16,
                          ),
                          label: const Text('Detailed Log'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.subtitleColor,
                            textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: List.generate(
                          provider.currentShipment!.steps.length,
                          (index) => TrackingStepItem(
                            step: provider.currentShipment!.steps[index],
                            isLast:
                                index ==
                                provider.currentShipment!.steps.length - 1,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 32, 20, 0),
                    child: VerificationCard(),
                  ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
                ] else
                  const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Icon(
                          IconsaxPlusLinear.search_status,
                          size: 64,
                          color: AppColors.lightGrey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Enter a tracking number to see\nyour shipment details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.subtitleColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(),
              ],
            );
          },
        ),
      ),
    );
  }
}
