import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/firebase_services.dart';
import '../../../../core/di/service_locator.dart';
import '../../../customs/domain/entities/declaration_entity.dart';
import '../provider/history_provider.dart';
import '../widgets/declaration_history_card.dart';
import 'history_details_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = getIt<FirebaseServices>().currentUser?.uid;
      if (userId != null) {
        context.read<HistoryProvider>().loadDeclarations(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, provider, child) {
        if (provider.errorMessage != null && provider.declarations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(provider.errorMessage!),
                TextButton(
                  onPressed: () {
                    final userId = getIt<FirebaseServices>().currentUser?.uid;
                    if (userId != null) {
                      provider.loadDeclarations(userId);
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (provider.declarations.isEmpty && !provider.isLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 64,
                  color: AppColors.greyText.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No declarations yet',
                  style: TextStyle(
                    color: AppColors.greyText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return Skeletonizer(
          enabled: provider.isLoading,
          child: RefreshIndicator(
            onRefresh: () async {
              final userId = getIt<FirebaseServices>().currentUser?.uid;
              if (userId != null) {
                await provider.loadDeclarations(userId);
              }
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: provider.isLoading ? 5 : provider.declarations.length,
              itemBuilder: (context, index) {
                final declaration =
                    provider.isLoading
                        ? _dummyDeclaration
                        : provider.declarations[index];
                return DeclarationHistoryCard(
                      declaration: declaration,
                      onTap: () {
                        if (provider.isLoading) return;
                        final historyProvider = context.read<HistoryProvider>();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ChangeNotifierProvider.value(
                                  value: historyProvider,
                                  child: HistoryDetailsScreen(
                                    declarationId: declaration.id!,
                                  ),
                                ),
                          ),
                        );
                      },
                    )
                    .animate()
                    .fadeIn(delay: (index * 50).ms)
                    .slideX(begin: 0.1, end: 0);
              },
            ),
          ),
        );
      },
    );
  }

  static final _dummyDeclaration = DeclarationEntity(
    id: 'DUMMY_ID_123',
    status: 'paid',
    totalCustoms: 100.0,
    totalVAT: 14.0,
    totalAmount: 114.0,
    createdAt: DateTime.now(),
  );
}
