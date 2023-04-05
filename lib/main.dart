// ignore_for_file: deprecated_member_use, avoid_print, depend_on_referenced_packages
import 'package:api_request/api_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/generator/localization_constant.dart';
import 'package:zat/presentation/screens/splash/splash.dart';
import 'core/constants/colors.dart';
import 'core/network/appbinding.dart';
import 'core/utiles/bloc_observer.dart';
import 'generator/codegen_loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBinding.initAsyncDependebcies();
  ApiRequestOptions.instance?.config(
    baseUrl: 'https://thaatty.com/api',
    tokenType: ApiRequestOptions.bearer,
    getToken: () => prefs.getString('token') ?? '',
    enableLog: true,
    defaultHeaders: {
      "Accept": "application/json",
      "lang": prefs.getString("lang") == "en"
          ? "en"
          // : (prefs.getString("lang") == "tr")
          //     ? "tr"

          : "ar"
    },
  );

  BlocOverrides.runZoned(
    () => runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
          Locale('tr', ''),
        ],
        path: 'asset/translation',
        assetLoader: const CodegenLoader(),
        child: const MyApp(),
      ),
    ),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setLocale(Locale locale) async {
    setState(() {
      context.locale = locale;
    });
    print('Applan:$locale');
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        context.locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TASAME',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: onGenerateRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Tajawal",
        scaffoldBackgroundColor: backgroundColor,
        backgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.white),
      ),
      home: const SplashScreen(),
    );
  }
}
