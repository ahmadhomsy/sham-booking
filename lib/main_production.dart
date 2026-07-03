import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/app.dart';
import 'package:sham_booking/core/bootstrap/bootstrap.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Bootstrap.init();
  final savedLanguage = box.read<String>(enLangKey);
  if (savedLanguage == null) {
    final deviceLanguage =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    await box.write(enLangKey, deviceLanguage);
  }
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      fallbackLocale: const Locale('en'),
      path: 'assets/lang',
      child: const MyApp(),
    ),
  );
}
