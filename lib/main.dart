import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smar_bin/modules/onBoarding/OnBoarding.dart';
import 'package:smar_bin/shared/blocObserver.dart';
import 'package:smar_bin/shared/cubit/cubit.dart';
import 'package:smar_bin/shared/network/local/cache_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  //Related to bloc states observation
  Bloc.observer = MyBlocObserver();
  //Related to Shared Preferences
  CacheHelper.init();

  // Get saved language or default to English
  // String langCode = CacheHelper.getData('language') ?? 'en';

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xff015ff3),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff015ff3),
            primary: const Color(0xff015ff3),
            secondary: const Color(0xff76B4C0),
          ),
          textTheme: const TextTheme(
            displayMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
          Locale('ar'),
        ],
        locale: Locale('en'),
        home: OnboardingScreen(),
      ),
    );
  }
}

