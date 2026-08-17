import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/helpers/go_router_helper.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';
import 'package:sham_booking/core/theme/app_theme.dart';
import 'package:sham_booking/core/theme/theme_cubit.dart';
import 'package:sham_booking/injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => di.sl<ThemeCubit>(),
      child: ScreenUtilInit(
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

          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                localizationsDelegates: localizationDelegates,
                supportedLocales: supportedLocales,
                locale: resolvedLocale,
                debugShowCheckedModeBanner: false,
                title: 'Sham Booking',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                routerConfig: router,
              );
            },
          );
        },
      ),
    );
  }
}
