import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:sham_booking/core/api/api_consumer.dart';
import 'package:sham_booking/core/api/api_interceptors.dart';
import 'package:sham_booking/core/api/dio_consumer.dart';
import 'package:dio/dio.dart';
import 'package:sham_booking/core/helpers/bloc_obs.dart';
import 'package:sham_booking/core/helpers/network_info.dart';
import 'package:sham_booking/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:sham_booking/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:sham_booking/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';
import 'package:sham_booking/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/logged_in_usecase.dart';
import 'package:sham_booking/features/auth/domain/usecases/logout_usecase.dart';
import 'package:sham_booking/features/auth/domain/usecases/send_verification_code_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/sign_in_user_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/sign_up_user_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/update_profile_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/verify_verification_code_use_case.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sham_booking/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_cubit.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  sl
    ..registerFactory<SplashCubit>(() => SplashCubit(loggedInUseCase: sl()))
    ..registerFactory<OnBoardingCubit>(OnBoardingCubit.new)
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        sendVerificationCodeUseCase: sl(),
        verificationCodeUseCase: sl(),
        signInUserUseCase: sl(),
        signUpUserUseCase: sl(),
      ),
    )
    ..registerLazySingleton<LoggedInUseCase>(() => LoggedInUseCase(sl()))
    ..registerLazySingleton<SignInUserUseCase>(() => SignInUserUseCase(sl()))
    ..registerLazySingleton<SignUpUserUseCase>(() => SignUpUserUseCase(sl()))
    ..registerLazySingleton<SendVerificationCodeUseCase>(
      () => SendVerificationCodeUseCase(sl()),
    )
    ..registerLazySingleton<VerifyVerificationCodeUseCase>(
      () => VerifyVerificationCodeUseCase(sl()),
    )
    ..registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(sl()))
    ..registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(sl()),
    )
    ..registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()))
    ..registerLazySingleton<AuthRepositories>(
      () => AuthRepositoryImpl(
        networkInfo: sl(),
        localDataSource: sl(),
        remoteAuthDataSource: sl(),
      ),
    )
    ..registerLazySingleton<LocalAuthDataSource>(
      () => LocalAuthDataSourceImpl(secureStorage: sl()),
    )
    ..registerLazySingleton<RemoteAuthDataSource>(
      () => RemoteAuthDataSourceImpl(sl()),
    )
    ..registerLazySingleton<ApiConsumer>(
      () => DioConsumer(dio: sl(), apiInterceptors: sl()),
    )
    ..registerLazySingleton(
      () => ApiInterceptors(sl()),
    )
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton(InternetConnectionChecker.createInstance)
    ..registerLazySingleton<Logger>(Logger.new)
    ..registerLazySingleton<MyBlocObserver>(() => MyBlocObserver(sl()));
}
