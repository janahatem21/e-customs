// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_customs/core/providers/user_provider.dart' as _i479;
import 'package:e_customs/core/services/firebase_services.dart' as _i1000;
import 'package:e_customs/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i263;
import 'package:e_customs/features/auth/data/repositories/auth_repository.dart'
    as _i678;
import 'package:e_customs/features/auth/presentation/providers/auth_provider.dart'
    as _i523;
import 'package:e_customs/features/documents/presentation/provider/upload_documents_provider.dart'
    as _i1060;
import 'package:e_customs/features/home/providers/home_provider.dart' as _i191;
import 'package:e_customs/features/notifications/presentation/providers/notification_provider.dart'
    as _i106;
import 'package:e_customs/features/payments/presentation/provider/fees_provider.dart'
    as _i552;
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
    gh.factory<_i191.HomeProvider>(() => _i191.HomeProvider());
    gh.factory<_i106.NotificationProvider>(() => _i106.NotificationProvider());
    gh.factory<_i552.FeesProvider>(() => _i552.FeesProvider());
    gh.lazySingleton<_i1000.FirebaseServices>(() => _i1000.FirebaseServices());
    gh.lazySingleton<_i924.ProfileProvider>(() => _i924.ProfileProvider());
    gh.lazySingleton<_i508.TrackingRepository>(
      () => _i508.TrackingRepositoryImpl(),
    );
    gh.lazySingleton<_i263.AuthRemoteDataSource>(
      () => _i263.AuthRemoteDataSourceImpl(gh<_i1000.FirebaseServices>()),
    );
    gh.singleton<_i479.UserProvider>(
      () => _i479.UserProvider(gh<_i1000.FirebaseServices>()),
    );
    gh.factory<_i473.TrackingProvider>(
      () => _i473.TrackingProvider(gh<_i508.TrackingRepository>()),
    );
    gh.lazySingleton<_i678.AuthRepository>(
      () => _i678.AuthRepositoryImpl(gh<_i263.AuthRemoteDataSource>()),
    );
    gh.factory<_i523.AuthProvider>(
      () => _i523.AuthProvider(
        gh<_i678.AuthRepository>(),
        gh<_i479.UserProvider>(),
      ),
    );
    return this;
  }
}
