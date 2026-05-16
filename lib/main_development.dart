import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/app.dart';
import 'package:sham_booking/core/bootstrap/bootstrap.dart';
import 'package:sham_booking/core/helpers/bloc_obs.dart';
import 'package:sham_booking/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Bootstrap.init();
  Bloc.observer = sl<MyBlocObserver>();
  runApp(const MyApp());
}
