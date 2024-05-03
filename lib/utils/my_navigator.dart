import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../feature/employee/main_page/main_page_provider.dart';

class Nav {
  /// Set the context once for convenience later
  static late BuildContext ctx;

  //push to new page
  static Future push<T extends Object>(Widget page, {BuildContext? context}) {
    final _ctx = context ?? ctx;
    FocusScope.of(_ctx).requestFocus(FocusNode());
    return Navigator.of(_ctx).push(
      MaterialPageRoute(builder: (_ctx) => page),
    );
  }

  //pop push to new page
  static Future popAndPush<T extends Object>(Widget page, {BuildContext? context}) {
    final _ctx = context ?? ctx;
    FocusScope.of(_ctx).requestFocus(FocusNode());
    pop(context: _ctx);
    return Navigator.of(_ctx).push(
      MaterialPageRoute(builder: (_ctx) => page),
    );
  }

  // pop return
  static pop<T extends Object>({BuildContext? context, T? data}) {
    final _ctx = context ?? ctx;
    return Navigator.pop(_ctx, data);
  }

  static void popToRoot({BuildContext? context}) {
    final _ctx = context ?? ctx;
    Navigator.popUntil(_ctx, (predicate) {
      return predicate.isFirst;
    });
  }

  static void popToHome({BuildContext? context}) {
    final _ctx = context ?? ctx;
    final mainProvider = Provider.of<MainProvider>(_ctx, listen: false);
    mainProvider.setTabBarSelectedIndex = 0;
    Navigator.popUntil(_ctx, (predicate) {
      return predicate.isFirst;
    });
  }

  static void pushAndRemove(Widget page, {int removeCount = 1, BuildContext? context}) {
    var index = 0;
    final _ctx = context ?? ctx;
    Navigator.of(_ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
          (route) {
        index++;
        return index > removeCount ? true : false;
      },
    );
  }

  // iOS
  static present(Widget page, {BuildContext? context}) {
    final _ctx = context ?? ctx;
    Navigator.of(_ctx).push(MaterialPageRoute(fullscreenDialog: true, builder: (context) => page));
  }
}