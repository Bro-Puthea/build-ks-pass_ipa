import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'my_app_bar.dart';

class MyScaffold extends Scaffold {
  MyScaffold(
      {super.key,
      String? title,
      PreferredSizeWidget? appBar,
      Widget? body,
      Widget? bottomButton,
      List<Widget>? actions,
      AppBarBackType leadType = AppBarBackType.back,
      WillPopCallback? onWillPop,
      Brightness brightness = Brightness.light,
      Widget? floatingActionButton,
      Color appBarBackgroundColor = AppColors.primaryColor,
      Color? titleColor,
      Color? leadingColor,
      Color? backgroundColor,
      bool centerTitle = false,
      FloatingActionButtonLocation? floatingActionButtonLocation})
      : super(
          appBar: appBar ??
              MyAppBar(
                elevation: 0.0,
                //brightness: Brightness.light,
                leadingType: leadType,
                onWillPop: onWillPop,
                actions: actions ?? [],
                leadingColor: leadingColor,
                centerTitle: centerTitle,
                title: MyTitle(title ?? '', color: titleColor ?? Colors.white),
                backgroundColor: appBarBackgroundColor,
              ),
          backgroundColor: backgroundColor ?? AppColors.primaryBackground,
          body: body,
          bottomNavigationBar: bottomButton,
          resizeToAvoidBottomInset: true,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
        );
}
