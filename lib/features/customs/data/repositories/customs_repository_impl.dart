import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/customs_constants.dart';
import '../../domain/repositories/customs_repository.dart';
import '../../domain/entities/item_entity.dart';
import '../datasources/customs_remote_data_source.dart';
import '../models/declaration_model.dart';

@Injectable(as: CustomsRepository)
class CustomsRepositoryImpl implements CustomsRepository {
  final CustomsRemoteDataSource _remoteDataSource;
  const CustomsRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> calculateCustoms({
    required String userId,
    required String declarationId,
  }) async {
    // Step 1: Fetch items
    final items = await _remoteDataSource.getItems(
      userId: userId,
      declarationId: declarationId,
    );

    double totalCustoms = 0.0;
    double totalVAT = 0.0;

    // Step 2: Calculate for each item
    for (final item in items) {
      if (item.isExempted) continue;

      // Handle missing category or mismatch by falling back to 'electronics'
      final category = item.category.toLowerCase();
      final rate = customsRates[category] ?? customsRates['electronics']!;

      final double itemTotalPrice = item.price * item.quantity;
      final double customs = itemTotalPrice * rate;
      final double vat = (itemTotalPrice + customs) * vatRate;

      totalCustoms += customs;
      totalVAT += vat;
    }

    // Step 3: Aggregate totals
    final double totalAmount = totalCustoms + totalVAT;

    // Step 4: Create updated declaration model
    final updatedDeclaration = DeclarationModel(
      status: AppConstants.statusDraft,
      totalCustoms: totalCustoms,
      totalVAT: totalVAT,
      totalAmount: totalAmount,
    );

    // Step 5: Update declaration status and totals
    await _remoteDataSource.updateDeclaration(
      userId: userId,
      declarationId: declarationId,
      declaration: updatedDeclaration,
    );
  }

  @override
  Future<List<ItemEntity>> getItems({
    required String userId,
    required String declarationId,
  }) async {
    return await _remoteDataSource.getItems(
      userId: userId,
      declarationId: declarationId,
    );
  }
}
