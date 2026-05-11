import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/services/firebase_services.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../provider/declaration_provider.dart';

class CreateDeclarationScreen extends StatelessWidget {
  const CreateDeclarationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const CustomBackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              IconsaxPlusLinear.document_text,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 32),
            const Text(
              'Start New Declaration',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.blackText,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'You need to create a declaration before adding items to your trip.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.greyText,
              ),
            ),
            const Spacer(),
            Consumer<DeclarationProvider>(
              builder: (context, provider, child) {
                return AppButton(
                  text: 'Create Declaration',
                  isLoading: provider.isLoading,
                  onPressed: () async {
                    final userId = getIt<FirebaseServices>().currentUser?.uid;
                    if (userId != null) {
                      final id = await provider.createNewDeclaration(userId);
                      if (id != null && context.mounted) {
                        final fromScreen =
                            ModalRoute.of(context)?.settings.arguments
                                    as String? ??
                                AppRouter.addItem;

                        Navigator.pushReplacementNamed(
                          context,
                          fromScreen,
                          arguments: id,
                        );
                      }
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
