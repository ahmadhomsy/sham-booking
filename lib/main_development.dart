import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/app.dart';
import 'package:sham_booking/core/bootstrap/bootstrap.dart';
import 'package:sham_booking/core/helpers/bloc_obs.dart';
import 'package:sham_booking/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Bootstrap.init();
  Bloc.observer = sl<MyBlocObserver>();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      fallbackLocale: const Locale('en'),
      path: 'assets/lang',
      child: const MyApp(),
    ),
  );
}
