import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/data/config/init_onesignal.dart';
import 'package:igt_e_pass_app/feature/visitor/home/home_page.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:provider/provider.dart';
import '../../../utils/general_utils.dart';
import '../../employee/main_page/main_page_provider.dart';

class VisitorsMainPage extends StatefulWidget {
  const VisitorsMainPage({super.key});

  @override
  State<VisitorsMainPage> createState() => _VisitorsMainPageState();
}

class _VisitorsMainPageState extends State<VisitorsMainPage>
    with AutomaticKeepAliveClientMixin {
  DateTime? currentBackPressTime;

  //hide splash screen
  Future<void> hideScreen() async {
    Future.delayed(const Duration(milliseconds: 750), () {});
  }

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
    final mainState = Provider.of<MainProvider>(context, listen: false);
    Nav.ctx = context;
    openHandlerOneSignal(context);
    return Scaffold(
        body: WillPopScope(
            onWillPop: () => onWillPop(),
            child: PageView(
                controller: mainState.tabBarPageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [HomePage()])));
  }

  @override
  bool get wantKeepAlive => true;
}
