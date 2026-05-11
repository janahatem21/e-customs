import 'package:e_customs/core/utils/app_dialogs.dart';
import 'package:e_customs/core/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/providers/user_provider.dart';
import '../provider/scan_invoice_provider.dart';
import '../widgets/scan_invoice_camera_view.dart';
import '../widgets/scan_invoice_processing_view.dart';
import '../widgets/scan_invoice_preview_view.dart';

class ScanInvoiceScreen extends StatefulWidget {
  const ScanInvoiceScreen({super.key});

  @override
  State<ScanInvoiceScreen> createState() => _ScanInvoiceScreenState();
}

class _ScanInvoiceScreenState extends State<ScanInvoiceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPassportId();
    });
  }

  void _checkPassportId() {
    final userProvider = context.read<UserProvider>();
    if (userProvider.user?.passportId == null) {
      AppDialogs.showPassportIdDialog(
        context,
        onConfirm: (passportId) => userProvider.updatePassportId(passportId),
      ).then((result) {
        if (result == 'back' && mounted) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Scan Invoice'),
      ),
      body: const SafeArea(child: _ScanInvoiceBodySwitcher()),
    );
  }
}

class _ScanInvoiceBodySwitcher extends StatelessWidget {
  const _ScanInvoiceBodySwitcher();

  @override
  Widget build(BuildContext context) {
    return Consumer<ScanInvoiceProvider>(
      builder: (context, provider, child) {
        return AnimatedSwitcher(
          duration: 400.ms,
          child:
              provider.isLoading
                  ? const ScanInvoiceProcessingView()
                  : provider.state == OcrState.success &&
                      provider.items.isNotEmpty
                  ? ScanInvoicePreviewView(provider: provider)
                  : ScanInvoiceCameraView(provider: provider),
        );
      },
    );
  }
}
