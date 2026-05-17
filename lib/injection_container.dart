import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:sham_booking/core/helpers/bloc_obs.dart';
import 'package:sham_booking/core/helpers/network_info.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  sl
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton(InternetConnectionChecker.createInstance)
    ..registerLazySingleton<Logger>(Logger.new)
    ..registerLazySingleton<MyBlocObserver>(() => MyBlocObserver(sl()));
}
