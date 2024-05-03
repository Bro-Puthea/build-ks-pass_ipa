import 'dart:io';
import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/feature/employee/main_page/main_page_provider.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final ValueChanged<int> onTap;

  MyBottomNavigationBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bottomBarHeight = 54 +
        MediaQuery.of(context).padding.bottom +
        (Platform.isAndroid ? 2 : 0);
    return SizedBox(
        height: bottomBarHeight, child: _getBottomNavigationBar(context));
  }

  List<Map<String, String>> tabBarData = [
    {
      "title": AppLocalizations.of(Nav.ctx)!.home,
      "image": "assets/icons/nav/home.png",
      "selectedImage": "assets/icons/nav/home.png",
    },
    {
      "title": AppLocalizations.of(Nav.ctx)!.vistors,
      "image": "assets/icons/nav/visitor.png",
      "selectedImage": "assets/icons/nav/visitor.png",
    },
    {
      "title": AppLocalizations.of(Nav.ctx)!.appointment,
      "image": "assets/icons/nav/pre_register.png",
      "selectedImage": "assets/icons/nav/pre_register.png",
    },
    {
      "title": AppLocalizations.of(Nav.ctx)!.my_profile,
      "image": "assets/icons/nav/user.png",
      "selectedImage": "assets/icons/nav/user.png",
    }
  ];

  _getBottomNavigationBar(BuildContext context) {
    return Stack(children: <Widget>[
      Selector<MainProvider, int>(
          builder: (_, index, __) {
            return BottomNavigationBar(
                //showSelectedLabels: false,
                //showUnselectedLabels: false,
                currentIndex: index,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 13,
                unselectedFontSize: 11,
                unselectedItemColor: AppColors.textFieldUnFocusColor,
                selectedItemColor: AppColors.primaryColorAccent,
                backgroundColor: Colors.black,
                elevation: 0,
                onTap: onTap,
                items: _getTabBar(context));
          },
          selector: (_, model) => model.getTabBarSelectIndex)
    ]);
  }

  List<BottomNavigationBarItem> _getTabBar(BuildContext context) {
    var index = 0;
    return tabBarData.map((item) {
      return _getBottomBarItem(item["title"], item["image"],
          item["selectedImage"], context, index++ == 3 ? Container() : null);
    }).toList();
  }

  BottomNavigationBarItem _getBottomBarItem(
      String? title, String? image, String? selectedImage, BuildContext context,
      [Widget? badge]) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabBarIconWidth = screenWidth / tabBarData.length;
    const tabBarIconHeight = 24.0;

    final badge0 =
        Positioned(left: tabBarIconWidth / 2 + 5, child: badge ?? Container());

    return BottomNavigationBarItem(
        icon: Stack(children: <Widget>[
          Image.asset(image!,
              width: tabBarIconWidth,
              height: tabBarIconHeight,
              color: AppColors.textFieldUnFocusColor),
          badge0
        ]),
        activeIcon: Stack(children: <Widget>[
          Image.asset(selectedImage!,
              width: tabBarIconWidth,
              height: tabBarIconHeight,
              color: AppColors.primaryColorAccent),
          badge0
        ]),
        label: title);
  }
}
