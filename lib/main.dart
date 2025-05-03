import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smar_bin/modules/onBoarding/OnBoarding.dart';
import 'package:smar_bin/shared/blocObserver.dart';
import 'package:smar_bin/shared/cubit/cubit.dart';
import 'package:smar_bin/shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Related to bloc states observation
  Bloc.observer = MyBlocObserver();

  // Load the saved language or default to English
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String langCode = prefs.getString('language') ?? 'en';  // Default to 'en' if no preference is found

  runApp(MyApp(langCode: langCode));
}

class MyApp extends StatelessWidget {
  final String langCode;

  const MyApp({Key? key, required this.langCode}) : super(key: key);

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
            secondary: const Color(0xffD6E4FF),
            outlineVariant: Colors.indigo.shade900,
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
        locale: Locale(langCode), // Apply the language globally from the prefs
        home: OnboardingScreen(), // No need to pass the onLanguageChanged function anymore
      ),
    );
  }
}
