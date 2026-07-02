import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/helpers/go_router_helper.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final easyLocalization = EasyLocalization.of(context);
        const fallbackLocale = Locale('en');
        final supportedLocales =
            easyLocalization?.supportedLocales ?? const [fallbackLocale];
        final localizationDelegates = easyLocalization?.delegates;

        final resolvedLocale = Locale(box.read<String>(enLangKey) ?? 'en');

        return MaterialApp.router(
          localizationsDelegates: localizationDelegates,
          supportedLocales: supportedLocales,
          locale: resolvedLocale,
          debugShowCheckedModeBanner: false,
          title: 'Sham Booking',
          // theme: AppTheme.light(),
          themeMode: ThemeMode.light,
          routerConfig: router,
        );
      },
    );
  }
}
