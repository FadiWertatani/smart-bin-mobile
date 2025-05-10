import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'package:smar_bin/modules/Auth.dart';
import 'package:smar_bin/modules/onBoarding/OnBoarding.dart';
import 'package:smar_bin/shared/blocObserver.dart';
import 'package:smar_bin/shared/cubit/cubit.dart';

// GlobalKey to access the app state and change language
final GlobalKey<_MyAppState> myAppKey = GlobalKey<_MyAppState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String langCode = prefs.getString('language') ?? 'en';
  bool onboardingSeen = prefs.getBool('onBoardingSeen') ?? false;

  runApp(MyAppWrapper(langCode: langCode, showOnBoarding: !onboardingSeen));
}

class MyAppWrapper extends StatelessWidget {
  final String langCode;
  final bool showOnBoarding;

  const MyAppWrapper({super.key, required this.langCode, required this.showOnBoarding});

  @override
  Widget build(BuildContext context) {
    return MyApp(
      key: myAppKey,
      langCode: langCode,
      showOnBoarding: showOnBoarding,
    );
  }
}

class MyApp extends StatefulWidget {
  final String langCode;
  final bool showOnBoarding;

  const MyApp({super.key, required this.langCode, required this.showOnBoarding});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.langCode);
  }

  void setLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLocale.languageCode);
    setState(() {
      _locale = newLocale;
    });
  }

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
        locale: _locale,
        home: widget.showOnBoarding ? const OnboardingScreen() : const AuthScreen(),
      ),
    );
  }
}
