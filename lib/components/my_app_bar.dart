import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';

/// appbar
enum AppBarBackType { back, close, none }

const double kNavigationBarHeight = 44.0;

// AppBar
class MyAppBar extends AppBar implements PreferredSizeWidget {
  MyAppBar(
      {Key? key,
      Widget? title,
      AppBarBackType? leadingType,
      WillPopCallback? onWillPop,
      Widget? leading,
      Brightness? brightness,
      Color? backgroundColor,
      List<Widget>? actions,
      Color? leadingColor,
      bool centerTitle = true,
      double? elevation})
      : super(
          key: key,
          title: title,
          centerTitle: centerTitle,
          //brightness: brightness ?? Brightness.light,
          backgroundColor: backgroundColor ?? const Color(0xFF0088CC),
          leading: leading ??
              (leadingType == AppBarBackType.none
                  ? Container()
                  : AppBarBack(
                      leadingType ?? AppBarBackType.back,
                      onWillPop: onWillPop,
                      color: leadingColor,
                    )),
          actions: actions,
          elevation: elevation ?? 0.5,
        );

  @override
  get preferredSize => const Size.fromHeight(44);
}

class AppBarBack extends StatelessWidget {
  final AppBarBackType _backType;
  final Color? color;
  final WillPopCallback? onWillPop;

  const AppBarBack(this._backType, {super.key, this.onWillPop, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final willBack = onWillPop == null ? true : await onWillPop!();
        if (!willBack) return;
        if(context.mounted) Navigator.pop(context);
      },
      child: _backType == AppBarBackType.close
          ? Icon(Icons.close,
              color: color ?? Colors.white, size: 24.0)
          : Container(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(Icons.arrow_back_rounded,
                  color: color ?? Colors.white),
            ),
    );
  }
}

class MyTitle extends StatelessWidget {
  final String _title;
  final Color? color;

  const MyTitle(this._title, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(_title,
        style: MyText.title(context)?.copyWith(
            color: color ?? AppColors.primaryText)
    );
  }
}
