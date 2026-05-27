import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:sham_booking/core/helpers/bloc_obs.dart';
import 'package:sham_booking/core/helpers/network_info.dart';
import 'package:sham_booking/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:sham_booking/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';
import 'package:sham_booking/features/auth/domain/usecases/logged_in_usecase.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_cubit.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  sl
    ..registerFactory<SplashCubit>(() => SplashCubit(loggedInUseCase: sl()))
    ..registerLazySingleton<LoggedInUseCase>(() => LoggedInUseCase(sl()))
    ..registerLazySingleton<AuthRepositories>(
      () => AuthRepositoryImpl(networkInfo: sl(), localDataSource: sl()),
    )
    ..registerLazySingleton<LocalAuthDataSource>(LocalAuthDataSourceImpl.new)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton(InternetConnectionChecker.createInstance)
    ..registerLazySingleton<Logger>(Logger.new)
    ..registerLazySingleton<MyBlocObserver>(() => MyBlocObserver(sl()));
}
