import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/routes/app_router.dart';


enum ScanState { camera, processing, preview }

class ScanInvoiceScreen extends StatefulWidget {
  const ScanInvoiceScreen({super.key});

  @override
  State<ScanInvoiceScreen> createState() => _ScanInvoiceScreenState();
}

class _ScanInvoiceScreenState extends State<ScanInvoiceScreen> {
  ScanState _currentState = ScanState.camera;

  void _startScanning() {
    setState(() => _currentState = ScanState.processing);
    // Simulate OCR processing delay
    Future.delayed(2500.ms, () {
      if (mounted) {
        setState(() => _currentState = ScanState.preview);
      }
    });
  }

  void _retakeScan() {
    setState(() => _currentState = ScanState.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            IconsaxPlusLinear.arrow_left,
            color: AppColors.blackText,
          ),
        ),
        title: const Text(
          'Scan Invoice',
          style: TextStyle(
            color: AppColors.blackText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: 400.ms,
          child: _buildCurrentStateUI(),
        ),
      ),
    );
  }

  Widget _buildCurrentStateUI() {
    switch (_currentState) {
      case ScanState.camera:
        return _buildCameraUI();
      case ScanState.processing:
        return _buildProcessingUI();
      case ScanState.preview:
        return _buildPreviewUI();
    }
  }

  Widget _buildCameraUI() {
    return Column(
      key: const ValueKey('camera'),
      children: [
        _buildStepIndicator(1),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCameraPreview(),
                const SizedBox(height: 24),
                const Text(
                  'Position invoice inside frame',
                  style: TextStyle(
                    color: AppColors.greyText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(delay: 200.ms),
              ],
            ),
          ),
        ),
        _buildBottomActions(
          primaryText: 'Capture Invoice',
          onPrimary: _startScanning,
          primaryIcon: const Icon(IconsaxPlusLinear.camera, size: 20),
        ),
      ],
    );
  }

  Widget _buildCameraPreview() {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.5)),
        ),
        child: Stack(
          children: [
            // Camera Placeholder Background
            Center(
              child: Icon(
                IconsaxPlusLinear.document_text_1,
                size: 64,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),

            // Scanning Frame Overlay
            Padding(
              padding: const EdgeInsets.all(32),
              child: CustomPaint(
                painter: _ScannerFramePainter(color: AppColors.primary),
                child: Container(),
              ),
            ),

            // Animated Scan Line
            _buildScanLine(),
          ],
        ),
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildScanLine() {
    return Positioned(
      top: 0,
      left: 32,
      right: 32,
      child: Container(
            height: 2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0),
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0),
                ],
              ),
            ),
          )
          .animate(onPlay: (controller) => controller.repeat())
          .moveY(
            begin: 100,
            end: 450, // Approx height based on aspect ratio
            duration: 2000.ms,
            curve: Curves.easeInOut,
          ),
    );
  }

  Widget _buildProcessingUI() {
    return Center(
      key: const ValueKey('processing'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.primary,
            ),
          ).animate().scale().fadeIn(),
          const SizedBox(height: 24),
          const Text(
            'Scanning invoice...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 8),
          Text(
            'Extracting data using AI',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.greyText.withValues(alpha: 0.7),
            ),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildPreviewUI() {
    return Column(
      key: const ValueKey('preview'),
      children: [
        _buildStepIndicator(2),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Detected Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackText,
                  ),
                ).animate().fadeIn().slideX(begin: -0.1, end: 0),
                const SizedBox(height: 16),
                _buildDetectedItemCard(
                  'iPhone 15 Pro',
                  '1,200.00 USD',
                  'Electronics',
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 12),
                _buildDetectedItemCard(
                  'Apple Watch Ultra 2',
                  '800.00 USD',
                  'Electronics',
                ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 24),
                AppCard(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.primary.withValues(alpha: 0.02),
                  child: Row(
                    children: [
                      const Icon(
                        IconsaxPlusLinear.info_circle,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Please verify the extracted data matches your invoice.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 500.ms),
              ],
            ),
          ),
        ),
        _buildBottomActions(
          primaryText: 'Confirm Data',
          onPrimary: () => Navigator.pushNamed(context, AppRouter.declaration),
          secondaryText: 'Retake Scan',
          onSecondary: _retakeScan,
        ),
      ],
    );
  }

  Widget _buildDetectedItemCard(String title, String price, String category) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              IconsaxPlusLinear.box,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.blackText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.greyText,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          _buildProgressDot(true),
          _buildProgressLine(step >= 2),
          _buildProgressDot(step >= 2),
          _buildProgressLine(step >= 3),
          _buildProgressDot(step >= 3),
        ],
      ),
    );
  }

  Widget _buildProgressDot(bool active) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color:
            active
                ? AppColors.primary
                : AppColors.lightGrey.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildProgressLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color:
            active
                ? AppColors.primary
                : AppColors.lightGrey.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildBottomActions({
    required String primaryText,
    required VoidCallback onPrimary,
    Widget? primaryIcon,
    String? secondaryText,
    VoidCallback? onSecondary,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (secondaryText != null) ...[
            Expanded(
              child: AppButton(
                text: secondaryText,
                variant: AppButtonVariant.outline,
                onPressed: onSecondary,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            flex: 2,
            child: AppButton(
              text: primaryText,
              onPressed: onPrimary,
              trailingIcon: primaryIcon,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerFramePainter extends CustomPainter {
  final Color color;

  _ScannerFramePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;

    const length = 30.0;

    // Top Left
    canvas.drawLine(const Offset(0, 0), const Offset(length, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, length), paint);

    // Top Right
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - length, 0),
      paint,
    );
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, length), paint);

    // Bottom Left
    canvas.drawLine(Offset(0, size.height), Offset(length, size.height), paint);
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - length),
      paint,
    );

    // Bottom Right
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - length, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
