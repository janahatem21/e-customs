import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/bottom_nav.dart';
import '../data/tracking_steps.dart';
import '../widgets/tracking_step_item.dart';


class TrackShipmentScreen extends StatelessWidget {
  const TrackShipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  _TrackHeader(
                    onBack: () => Navigator.pop(context),
                    onNotifications: () {
                      Navigator.pushNamed(context, AppRouter.notifications);
                    },
                  ),
                  const _SearchSection(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: _DarkInfoCard(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Shipment Journey',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackText,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'View Detailed Log',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.subtitleColor,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: AppColors.subtitleColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: AppCard(
                      child: Column(
                        children: List.generate(
                          trackingSteps.length,
                              (index) => TrackingStepItem(
                            step: trackingSteps[index],
                            isLast: index == trackingSteps.length - 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: _VerificationCard(),
                  ),
                ],
              ),
            ),
            const BottomNav(currentIndex: 1),
          ],
        ),
      ),
    );
  }
}

class _TrackHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onNotifications;

  const _TrackHeader({
    required this.onBack,
    required this.onNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: AppColors.blackText,
            ),
          ),
          const Expanded(
            child: Text(
              'Track Shipment',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.blackText,
              ),
            ),
          ),
          IconButton(
            onPressed: onNotifications,
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 20,
              color: AppColors.blackText,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrey.withOpacity(0.5),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter Tracking Number',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.subtitleColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.lightGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: TextEditingController(text: 'EC-882944012'),
                    decoration: const InputDecoration(
                      hintText: 'EC-882944012',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.blackText,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 16,
                        color: AppColors.subtitleColor,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                  ),
                  child: const Text(
                    'Track',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Tracking since Oct 20, 2023. Updated 5 mins ago.',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _DarkInfoCard extends StatelessWidget {
  const _DarkInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.inventory_2_outlined,
                size: 16,
                color: Colors.white70,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'EC-882944012',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'In Transit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoBlock(
                label: 'Estimated Arrival',
                value: 'Oct 26, 2023',
                alignEnd: false,
              ),
              _InfoBlock(
                label: 'Current Location',
                value: 'Los Angeles, CA',
                alignEnd: true,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shanghai (Origin)',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white60,
                ),
              ),
              Text(
                'Los Angeles (Dest)',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.75,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;
  final bool alignEnd;

  const _InfoBlock({
    required this.label,
    required this.value,
    required this.alignEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 9,
            letterSpacing: 1,
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _VerificationCard extends StatelessWidget {
  const _VerificationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.gradientMid,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.shield_outlined,
            size: 24,
            color: AppColors.subtitleColor,
          ),
          SizedBox(height: 8),
          Text(
            'Secure Customs Verification',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.blackText,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Your shipment is monitored and verified by E-Customs for regulatory compliance.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: AppColors.subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}