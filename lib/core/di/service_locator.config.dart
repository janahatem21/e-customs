// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_customs/core/providers/user_provider.dart' as _i479;
import 'package:e_customs/core/services/fcm_service.dart' as _i612;
import 'package:e_customs/core/services/firebase_services.dart' as _i1000;
import 'package:e_customs/core/services/ocr_service.dart' as _i693;
import 'package:e_customs/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i263;
import 'package:e_customs/features/auth/data/repositories/auth_repository.dart'
    as _i678;
import 'package:e_customs/features/auth/presentation/providers/auth_provider.dart'
    as _i523;
import 'package:e_customs/features/customs/data/datasources/customs_remote_data_source.dart'
    as _i223;
import 'package:e_customs/features/customs/data/datasources/declarations_remote_data_source.dart'
    as _i577;
import 'package:e_customs/features/customs/data/datasources/items_remote_data_source.dart'
    as _i112;
import 'package:e_customs/features/customs/data/datasources/ocr_remote_data_source.dart'
    as _i80;
import 'package:e_customs/features/customs/data/repositories/customs_repository_impl.dart'
    as _i15;
import 'package:e_customs/features/customs/data/repositories/declarations_repository_impl.dart'
    as _i580;
import 'package:e_customs/features/customs/data/repositories/items_repository_impl.dart'
    as _i341;
import 'package:e_customs/features/customs/data/repositories/ocr_repository_impl.dart'
    as _i961;
import 'package:e_customs/features/customs/domain/repositories/customs_repository.dart'
    as _i568;
import 'package:e_customs/features/customs/domain/repositories/declarations_repository.dart'
    as _i872;
import 'package:e_customs/features/customs/domain/repositories/items_repository.dart'
    as _i53;
import 'package:e_customs/features/customs/domain/repositories/ocr_repository.dart'
    as _i511;
import 'package:e_customs/features/customs/domain/usecases/add_item_usecase.dart'
    as _i1062;
import 'package:e_customs/features/customs/domain/usecases/calculate_customs_usecase.dart'
    as _i480;
import 'package:e_customs/features/customs/domain/usecases/confirm_calculation_usecase.dart'
    as _i203;
import 'package:e_customs/features/customs/domain/usecases/create_declaration_usecase.dart'
    as _i98;
import 'package:e_customs/features/customs/domain/usecases/get_active_declaration_usecase.dart'
    as _i590;
import 'package:e_customs/features/customs/domain/usecases/get_declaration_by_id_usecase.dart'
    as _i563;
import 'package:e_customs/features/customs/domain/usecases/get_items_usecase.dart'
    as _i945;
import 'package:e_customs/features/customs/domain/usecases/get_latest_calculated_declaration_usecase.dart'
    as _i347;
import 'package:e_customs/features/customs/domain/usecases/scan_invoice_usecase.dart'
    as _i523;
import 'package:e_customs/features/customs/presentation/provider/add_item_provider.dart'
    as _i977;
import 'package:e_customs/features/customs/presentation/provider/calculate_provider.dart'
    as _i231;
import 'package:e_customs/features/customs/presentation/provider/declaration_provider.dart'
    as _i125;
import 'package:e_customs/features/customs/presentation/provider/scan_invoice_provider.dart'
    as _i777;
import 'package:e_customs/features/documents/presentation/provider/upload_documents_provider.dart'
    as _i1060;
import 'package:e_customs/features/history/data/datasources/history_remote_data_source.dart'
    as _i1060;
import 'package:e_customs/features/history/data/datasources/history_remote_data_source_impl.dart'
    as _i809;
import 'package:e_customs/features/history/data/repositories/history_repository_impl.dart'
    as _i163;
import 'package:e_customs/features/history/domain/repositories/history_repository.dart'
    as _i765;
import 'package:e_customs/features/history/domain/usecases/get_declaration_details_usecase.dart'
    as _i617;
import 'package:e_customs/features/history/domain/usecases/get_declaration_items_usecase.dart'
    as _i264;
import 'package:e_customs/features/history/domain/usecases/get_declarations_usecase.dart'
    as _i790;
import 'package:e_customs/features/history/presentation/provider/history_provider.dart'
    as _i399;
import 'package:e_customs/features/home/providers/home_provider.dart' as _i191;
import 'package:e_customs/features/notifications/data/datasources/notifications_remote_data_source.dart'
    as _i259;
import 'package:e_customs/features/notifications/data/repositories/notifications_repository_impl.dart'
    as _i607;
import 'package:e_customs/features/notifications/domain/repositories/notifications_repository.dart'
    as _i610;
import 'package:e_customs/features/notifications/domain/usecases/get_notifications_usecase.dart'
    as _i1004;
import 'package:e_customs/features/notifications/domain/usecases/get_unread_notifications_count_usecase.dart'
    as _i950;
import 'package:e_customs/features/notifications/domain/usecases/mark_all_notifications_as_read_usecase.dart'
    as _i228;
import 'package:e_customs/features/notifications/domain/usecases/mark_notification_as_read_usecase.dart'
    as _i838;
import 'package:e_customs/features/notifications/presentation/providers/notification_provider.dart'
    as _i106;
import 'package:e_customs/features/payments/data/datasources/payment_remote_data_source.dart'
    as _i321;
import 'package:e_customs/features/payments/data/repositories/payment_repository_impl.dart'
    as _i235;
import 'package:e_customs/features/payments/domain/repositories/payment_repository.dart'
    as _i1069;
import 'package:e_customs/features/payments/domain/usecases/complete_payment_usecase.dart'
    as _i1049;
import 'package:e_customs/features/payments/presentation/provider/payment_provider.dart'
    as _i773;
import 'package:e_customs/features/profile/data/datasources/profile_remote_datasource.dart'
    as _i398;
import 'package:e_customs/features/profile/data/repositories/profile_repository.dart'
    as _i682;
import 'package:e_customs/features/profile/presentation/provider/profile_provider.dart'
    as _i924;
import 'package:e_customs/features/tracking/data/repositories/tracking_repository.dart'
    as _i508;
import 'package:e_customs/features/tracking/presentation/providers/tracking_provider.dart'
    as _i473;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i1060.UploadDocumentsProvider>(
      () => _i1060.UploadDocumentsProvider(),
    );
    gh.lazySingleton<_i612.FCMService>(() => _i612.FCMService());
    gh.lazySingleton<_i1000.FirebaseServices>(() => _i1000.FirebaseServices());
    gh.lazySingleton<_i693.OcrService>(() => _i693.OcrService());
    gh.lazySingleton<_i112.ItemsRemoteDataSource>(
      () => _i112.ItemsRemoteDataSourceImpl(gh<_i1000.FirebaseServices>()),
    );
    gh.factory<_i223.CustomsRemoteDataSource>(
      () => _i223.CustomsRemoteDataSourceImpl(gh<_i1000.FirebaseServices>()),
    );
    gh.lazySingleton<_i259.NotificationsRemoteDataSource>(
      () => _i259.NotificationsRemoteDataSourceImpl(
        gh<_i1000.FirebaseServices>(),
      ),
    );
    gh.lazySingleton<_i508.TrackingRepository>(
      () => _i508.TrackingRepositoryImpl(),
    );
    gh.lazySingleton<_i263.AuthRemoteDataSource>(
      () => _i263.AuthRemoteDataSourceImpl(gh<_i1000.FirebaseServices>()),
    );
    gh.singleton<_i479.UserProvider>(
      () => _i479.UserProvider(gh<_i1000.FirebaseServices>()),
    );
    gh.lazySingleton<_i398.ProfileRemoteDataSource>(
      () => _i398.ProfileRemoteDataSourceImpl(gh<_i1000.FirebaseServices>()),
    );
    gh.lazySingleton<_i577.DeclarationsRemoteDataSource>(
      () =>
          _i577.DeclarationsRemoteDataSourceImpl(gh<_i1000.FirebaseServices>()),
    );
    gh.lazySingleton<_i80.OcrRemoteDataSource>(
      () => _i80.OcrRemoteDataSourceImpl(gh<_i693.OcrService>()),
    );
    gh.factory<_i568.CustomsRepository>(
      () => _i15.CustomsRepositoryImpl(gh<_i223.CustomsRemoteDataSource>()),
    );
    gh.factory<_i53.ItemsRepository>(
      () => _i341.ItemsRepositoryImpl(gh<_i112.ItemsRemoteDataSource>()),
    );
    gh.lazySingleton<_i1060.HistoryRemoteDataSource>(
      () => _i809.HistoryRemoteDataSourceImpl(gh<_i1000.FirebaseServices>()),
    );
    gh.lazySingleton<_i321.PaymentRemoteDataSource>(
      () => _i321.PaymentRemoteDataSourceImpl(gh<_i1000.FirebaseServices>()),
    );
    gh.factory<_i872.DeclarationsRepository>(
      () => _i580.DeclarationsRepositoryImpl(
        gh<_i577.DeclarationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i1062.AddItemsUseCase>(
      () => _i1062.AddItemsUseCase(gh<_i53.ItemsRepository>()),
    );
    gh.factory<_i610.NotificationsRepository>(
      () => _i607.NotificationsRepositoryImpl(
        gh<_i259.NotificationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i480.CalculateCustomsUseCase>(
      () => _i480.CalculateCustomsUseCase(gh<_i568.CustomsRepository>()),
    );
    gh.factory<_i473.TrackingProvider>(
      () => _i473.TrackingProvider(gh<_i508.TrackingRepository>()),
    );
    gh.lazySingleton<_i678.AuthRepository>(
      () => _i678.AuthRepositoryImpl(gh<_i263.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i511.OcrRepository>(
      () => _i961.OcrRepositoryImpl(gh<_i80.OcrRemoteDataSource>()),
    );
    gh.factory<_i765.HistoryRepository>(
      () => _i163.HistoryRepositoryImpl(gh<_i1060.HistoryRemoteDataSource>()),
    );
    gh.lazySingleton<_i682.ProfileRepository>(
      () => _i682.ProfileRepositoryImpl(gh<_i398.ProfileRemoteDataSource>()),
    );
    gh.factory<_i945.GetItemsUseCase>(
      () => _i945.GetItemsUseCase(gh<_i568.CustomsRepository>()),
    );
    gh.factory<_i203.ConfirmCalculationUseCase>(
      () => _i203.ConfirmCalculationUseCase(gh<_i872.DeclarationsRepository>()),
    );
    gh.factory<_i98.CreateDeclarationUseCase>(
      () => _i98.CreateDeclarationUseCase(gh<_i872.DeclarationsRepository>()),
    );
    gh.factory<_i590.GetActiveDeclarationUseCase>(
      () =>
          _i590.GetActiveDeclarationUseCase(gh<_i872.DeclarationsRepository>()),
    );
    gh.factory<_i563.GetDeclarationByIdUseCase>(
      () => _i563.GetDeclarationByIdUseCase(gh<_i872.DeclarationsRepository>()),
    );
    gh.factory<_i347.GetLatestCalculatedDeclarationUseCase>(
      () => _i347.GetLatestCalculatedDeclarationUseCase(
        gh<_i872.DeclarationsRepository>(),
      ),
    );
    gh.factory<_i523.AuthProvider>(
      () => _i523.AuthProvider(
        gh<_i678.AuthRepository>(),
        gh<_i479.UserProvider>(),
      ),
    );
    gh.factory<_i617.GetDeclarationDetailsUseCase>(
      () => _i617.GetDeclarationDetailsUseCase(gh<_i765.HistoryRepository>()),
    );
    gh.factory<_i264.GetDeclarationItemsUseCase>(
      () => _i264.GetDeclarationItemsUseCase(gh<_i765.HistoryRepository>()),
    );
    gh.factory<_i790.GetDeclarationsUseCase>(
      () => _i790.GetDeclarationsUseCase(gh<_i765.HistoryRepository>()),
    );
    gh.factory<_i1069.PaymentRepository>(
      () => _i235.PaymentRepositoryImpl(gh<_i321.PaymentRemoteDataSource>()),
    );
    gh.factory<_i977.AddItemProvider>(
      () => _i977.AddItemProvider(gh<_i1062.AddItemsUseCase>()),
    );
    gh.factory<_i1004.GetNotificationsUseCase>(
      () => _i1004.GetNotificationsUseCase(gh<_i610.NotificationsRepository>()),
    );
    gh.factory<_i950.GetUnreadNotificationsCountUseCase>(
      () => _i950.GetUnreadNotificationsCountUseCase(
        gh<_i610.NotificationsRepository>(),
      ),
    );
    gh.factory<_i228.MarkAllNotificationsAsReadUseCase>(
      () => _i228.MarkAllNotificationsAsReadUseCase(
        gh<_i610.NotificationsRepository>(),
      ),
    );
    gh.factory<_i838.MarkNotificationAsReadUseCase>(
      () => _i838.MarkNotificationAsReadUseCase(
        gh<_i610.NotificationsRepository>(),
      ),
    );
    gh.factory<_i231.CalculateProvider>(
      () => _i231.CalculateProvider(
        gh<_i480.CalculateCustomsUseCase>(),
        gh<_i945.GetItemsUseCase>(),
        gh<_i563.GetDeclarationByIdUseCase>(),
        gh<_i203.ConfirmCalculationUseCase>(),
      ),
    );
    gh.factory<_i523.ScanInvoiceUseCase>(
      () => _i523.ScanInvoiceUseCase(gh<_i511.OcrRepository>()),
    );
    gh.factory<_i125.DeclarationProvider>(
      () => _i125.DeclarationProvider(
        gh<_i590.GetActiveDeclarationUseCase>(),
        gh<_i98.CreateDeclarationUseCase>(),
        gh<_i347.GetLatestCalculatedDeclarationUseCase>(),
      ),
    );
    gh.factory<_i399.HistoryProvider>(
      () => _i399.HistoryProvider(
        gh<_i790.GetDeclarationsUseCase>(),
        gh<_i617.GetDeclarationDetailsUseCase>(),
        gh<_i264.GetDeclarationItemsUseCase>(),
      ),
    );
    gh.factory<_i191.HomeProvider>(
      () => _i191.HomeProvider(gh<_i765.HistoryRepository>()),
    );
    gh.factory<_i777.ScanInvoiceProvider>(
      () => _i777.ScanInvoiceProvider(
        gh<_i523.ScanInvoiceUseCase>(),
        gh<_i1062.AddItemsUseCase>(),
      ),
    );
    gh.factory<_i924.ProfileProvider>(
      () => _i924.ProfileProvider(
        gh<_i682.ProfileRepository>(),
        gh<_i678.AuthRepository>(),
      ),
    );
    gh.factory<_i1049.CompletePaymentUseCase>(
      () => _i1049.CompletePaymentUseCase(gh<_i1069.PaymentRepository>()),
    );
    gh.factory<_i106.NotificationsProvider>(
      () => _i106.NotificationsProvider(
        gh<_i1004.GetNotificationsUseCase>(),
        gh<_i228.MarkAllNotificationsAsReadUseCase>(),
        gh<_i838.MarkNotificationAsReadUseCase>(),
        gh<_i950.GetUnreadNotificationsCountUseCase>(),
      ),
    );
    gh.factory<_i773.PaymentProvider>(
      () => _i773.PaymentProvider(
        gh<_i1049.CompletePaymentUseCase>(),
        gh<_i872.DeclarationsRepository>(),
      ),
    );
    return this;
  }
}
