import 'dart:async';
import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/components/build_bg_image.dart';
import 'package:igt_e_pass_app/data/config/init_onesignal.dart';
import 'package:igt_e_pass_app/feature/employee/main_page/main_page.dart';
import 'package:igt_e_pass_app/feature/visitor/login/login_page.dart';
import 'package:igt_e_pass_app/feature/visitor/main/main_page.dart';
import 'package:igt_e_pass_app/resource/constant.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';
import 'package:provider/provider.dart';
import 'l10n/providers/local_provider.dart';
import 'utils/preference_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initOneSignal();
    _goToNextPage(delaySec: 500, context: context);
    super.initState();
  }

  _goToNextPage({required int delaySec, required BuildContext context}) async {
    Timer(Duration(milliseconds: delaySec), () async {
      if (!await getIsLogin()) {
        if (context.mounted) {
          Nav.pushAndRemove(const LoginPage(), context: context);
        }
      } else {
        if (await getGroupName() == Const.security) {
          if (context.mounted) {
            Nav.pushAndRemove(const VisitorsMainPage(), context: context);
          }
        } else {
          if (context.mounted) {
            Nav.pushAndRemove(const EmployeeMainPage(), context: context);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LocaleProvider>(context, listen: false);
    getLangCode().then((value) {
      state.setLocale(Locale.fromSubtags(
          languageCode: PrefsHelper.getString(Const.lang) ?? 'en'));
    });

    return const Scaffold(body: BuildBgImage());
  }
}
