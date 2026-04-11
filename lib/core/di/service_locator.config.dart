// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_customs/features/home/providers/home_provider.dart' as _i191;
import 'package:e_customs/features/notifications/presentation/providers/notification_provider.dart'
    as _i106;
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
    gh.factory<_i191.HomeProvider>(() => _i191.HomeProvider());
    gh.factory<_i106.NotificationProvider>(() => _i106.NotificationProvider());
    gh.lazySingleton<_i508.TrackingRepository>(
      () => _i508.TrackingRepositoryImpl(),
    );
    gh.factory<_i473.TrackingProvider>(
      () => _i473.TrackingProvider(gh<_i508.TrackingRepository>()),
    );
    return this;
  }
}
