import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/data/config/init_onesignal.dart';
import 'package:igt_e_pass_app/feature/employee/home/home_page.dart';
import 'package:igt_e_pass_app/feature/employee/visitor/all_visitors_page.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:provider/provider.dart';
import '../../../components/my_bottom_navigation_bar.dart';
import '../../../utils/general_utils.dart';
import '../pre_register/pre_register_page.dart';
import '../profile/profile_page.dart';
import 'main_page_provider.dart';

class EmployeeMainPage extends StatefulWidget {
  const EmployeeMainPage({super.key});

  @override
  State<EmployeeMainPage> createState() => _EmployeeMainPageState();
}

class _EmployeeMainPageState extends State<EmployeeMainPage>
    with AutomaticKeepAliveClientMixin {
  DateTime? currentBackPressTime;

  //hide splash screen
  Future<void> hideScreen() async {
    Future.delayed(const Duration(milliseconds: 750), () {});
  }

  // double tap to exit app
  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      GeneralUtil.showToast(AppLocalizations.of(context)!.click_again_to_exist);
      return Future.value(false);
    }
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    openHandlerOneSignal(context);
    final mainState = Provider.of<MainProvider>(context, listen: false);
    Nav.ctx = context;

    return Scaffold(
        body: WillPopScope(
            onWillPop: () => onWillPop(),
            child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: mainState.tabBarPageController,
                children: const [
                  EmployeeHomePage(),
                  AllVisitorsPage(isButtonBack: false),
                  PreRegisterPage(isButtonBack: false),
                  ProfilePage(isButtonBack: false)
                ])),
        bottomNavigationBar: MyBottomNavigationBar(onTap: (index) {
          mainState.tabBarPageController.jumpToPage(index);
          setState(() => mainState.setTabBarSelectedIndex = index);
        }));
  }

  @override
  bool get wantKeepAlive => true;
}
