import 'package:flutter/material.dart';


class MainProvider extends ChangeNotifier {
    final PageController tabBarPageController = PageController(
      initialPage: 0
    );
   int _tabBarSelectIndex = 0;
   int get getTabBarSelectIndex =>_tabBarSelectIndex;

   set setTabBarSelectedIndex (int value) {
      tabBarPageController.animateToPage(
          value,
          duration: const Duration(microseconds: 300),
          curve: Curves.easeIn,
      );
      _tabBarSelectIndex = value;
      notifyListeners();
   }
  //message display after processing
}

