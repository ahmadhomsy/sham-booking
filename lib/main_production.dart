import 'package:flutter/material.dart';
import 'package:sham_booking/app.dart';
import 'package:sham_booking/core/bootstrap/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Bootstrap.init();
  runApp(const MyApp());
}
