import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/presentation/cubit/theme.state.dart';
import 'package:se7ety/core/presentation/cubit/theme_cubit.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/firebase/notification_handler.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/utils/themes.dart';
import 'package:se7ety/environment_congig.dart';
import 'package:se7ety/firebase_options.dart';

// themes :

// ignore: non_constant_identifier_names
Future<void> mainCommon(EnvironmentConfig environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPref.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FCMHandler.init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      child: DevicePreview(
        enabled: true,
        builder: (context) => const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          bool isDark = context.read<ThemeCubit>().isDarkTheme;
          return MaterialApp.router(
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: Routes.routes,
          );
        },
      ),
    );
  }
}
