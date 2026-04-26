// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:vpnapp/core/bloc/app_bloc_observer.dart' as _i328;
import 'package:vpnapp/core/di/register_modules.dart' as _i390;
import 'package:vpnapp/core/utils/v2ray_service.dart' as _i877;
import 'package:vpnapp/src/data/data_sources/home_remote_data_source.dart'
    as _i956;
import 'package:vpnapp/src/data/repositories/home_repository_impl.dart'
    as _i734;
import 'package:vpnapp/src/domain/repositories/home_repository.dart' as _i600;
import 'package:vpnapp/src/domain/use_cases/get_remote_ipinfo_use_case.dart'
    as _i241;
import 'package:vpnapp/src/presentation/cubit/home_cubit.dart' as _i855;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i974.Logger>(() => registerModule.logger);
    gh.lazySingleton<_i328.AppBlocObserver>(
      () => registerModule.blocObserver(gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio(gh<_i974.Logger>()));
    gh.lazySingleton<_i956.HomeRemoteDataSource>(
      () => _i956.HomeRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i600.HomeRepository>(
      () => _i734.HomeRepositoryImpl(gh<_i956.HomeRemoteDataSource>()),
    );
    gh.factory<_i241.GetRemoteIpinfoUseCase>(
      () => _i241.GetRemoteIpinfoUseCase(gh<_i600.HomeRepository>()),
    );
    gh.lazySingleton<_i855.HomeCubit>(
      () => _i855.HomeCubit(
        gh<_i877.V2RayService>(),
        gh<_i241.GetRemoteIpinfoUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i390.RegisterModule {}
