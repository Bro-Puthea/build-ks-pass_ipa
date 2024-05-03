import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:igt_e_pass_app/data/config/init_onesignal.dart';
import 'package:igt_e_pass_app/resource/my_strings.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/utils/preference_helper.dart';
import 'package:provider/provider.dart';
import 'feature/employee/main_page/main_page_provider.dart';
import 'l10n/providers/local_provider.dart';
import 'splash_screen.dart';
import 'utils/behavior_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await availableCameras();
  await PrefsHelper.init();
  await initOneSignal();

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MainProvider()),
    ChangeNotifierProvider(create: (_) => LocaleProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initOneSignal();
    final state = Provider.of<LocaleProvider>(context);
    return MaterialApp(
        title: MyStrings.appName,
        debugShowCheckedModeBanner: false,
        locale: state.locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('km'), // khmer
          Locale('zh'), // chinese
        ],
        theme: ThemeData(
            unselectedWidgetColor: AppColors.textFieldUnFocusColor,
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColors.primaryColor,
                secondary: AppColors.primaryColorAccent)),
        home: const SplashScreen(),
        builder: (context, child) {
          initOneSignal();
          child = EasyLoading.init()(context, child);
          //child = MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child);
          child = ScrollConfiguration(behavior: MyBehavior(), child: child);
          return child;
        });
  }
}
