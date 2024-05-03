import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:igt_e_pass_app/resource/app_url.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../feature/employee/main_page/main_page_provider.dart';
import '../feature/visitor/login/login_page.dart';
import 'storage_utils.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class GeneralUtil {
  static final GeneralUtil _singleton = GeneralUtil._internal();

  factory GeneralUtil() => _singleton;

  GeneralUtil._internal();

  static void log(Object object) {
    if (kDebugMode) {
      print(object);
    }
  }

  static Future<dynamic> signOut(BuildContext context) async {
    await clearUserData();
    if (AppUrl.requiredSignInFirst) {
      Nav.pushAndRemove(const LoginPage(), removeCount: 10);
      if (context.mounted) {
        final mainProvider = Provider.of<MainProvider>(context, listen: false);
        mainProvider.setTabBarSelectedIndex = 0;
      }
    } else {
      Nav.popToHome();
    }
  }

  static void showLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      //..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 55.0
      ..radius = 10.0
      ..progressColor = Colors.red
      ..backgroundColor = Colors.black
      ..indicatorColor = Colors.red
      ..textColor = Colors.white
      //..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.black.withOpacity(0.7)
      ..userInteractions = true
      ..dismissOnTap = true;
  }

  static dismissKeyboardFocus() {
    FocusScope.of(Nav.ctx).requestFocus(FocusNode());
  }

  static isIOS() {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  static Future<dynamic> showSnackBarMessage({
    String? message,
    Function? onTap,
    BuildContext? context,
    bool isSuccess = true,
  }) {
    return showFlash(
      context: context ?? Nav.ctx,
      duration: const Duration(seconds: 2),
      persistent: true,
      barrierDismissible: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          position: FlashPosition.bottom,
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: FlashBar(
            useSafeArea: true,
            backgroundColor: isSuccess ? Colors.green : Colors.red,
            title: Text(
              isSuccess ? 'Success' : 'Error',
              style: MyText.title(context ?? Nav.ctx),
            ),
            content: Text(
              message ?? '',
              style: MyText.subtitle(context ?? Nav.ctx),
            ),
            controller: controller,
          ),
        );
      },
    );
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColors.primaryColorAccent,
        backgroundColor: Colors.black,
        fontSize: 13.0);
  }

  static showAlertDialog({
    BuildContext? context,
    String? title,
    String? subTittle,
    String? negativeButtonTitle,
    String? positiveButtonTitle,
    VoidCallback? onPositiveButton,
    VoidCallback? onNegativeButton,
  }) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(negativeButtonTitle ?? 'Cancel',
          style: MyText.button(context ?? Nav.ctx)?.copyWith()),
      onPressed: () {
        Nav.pop();
        onNegativeButton!.call();
      },
    );
    Widget continueButton = TextButton(
      child: Text(positiveButtonTitle ?? "Continue",
          style: MyText.button(context ?? Nav.ctx)),
      onPressed: () {
        Nav.pop();
        onPositiveButton!.call();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: AppColors.primaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        title ?? '',
        style: MyText.title(context ?? Nav.ctx),
      ),
      content: Text(
        subTittle ?? '',
        style: MyText.subtitle(context ?? Nav.ctx),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context ?? Nav.ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showErrrDialog({
    BuildContext? context,
    String? title,
    String? subtitle,
    String? negativeButtonTitle,
    String? positiveButtonTitle,
    VoidCallback? onPositiveButton,
    VoidCallback? onNegativeButton,
  }) {
    AwesomeDialog(
      context: context ?? Nav.ctx,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: title ?? 'Success?',
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      desc: subtitle ?? 'Successful',
      btnCancelText: negativeButtonTitle,
      btnOkText: positiveButtonTitle,
      buttonsTextStyle: MyText.body1(context ?? Nav.ctx),
      btnCancelOnPress: () {
        onNegativeButton!.call();
      },
      btnOkOnPress: () {
        onPositiveButton!.call();
      },
    ).show();
  }

  static void showSucessDialog({
    BuildContext? context,
    String? title,
    String? subtitle,
    String? negativeButtonTitle,
    String? positiveButtonTitle,
    VoidCallback? onPositiveButton,
    VoidCallback? onNegativeButton,
  }) {
    AwesomeDialog(
      context: context ?? Nav.ctx,
      dialogType: DialogType.success,
      //animType: AnimType.bottomSlide,
      title: title ?? 'Delete?',
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      desc: subtitle ?? 'Are you sure you want to delete this item?',
      //btnCancelText: negativeButtonTitle,
      btnOkText: positiveButtonTitle,
      buttonsTextStyle: MyText.body1(context ?? Nav.ctx),
      // btnCancelOnPress: () {
      //   onNegativeButton!.call();
      // },
      btnOkOnPress: () {
        Nav.pop(context: context ?? Nav.ctx);
        onPositiveButton!.call();
      },
    ).show();
  }

  //date utils
  static Future<DateTime?> showDatesPicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    return selectedDate;
  }

  static Future<String?> showTimesPicker({
    required BuildContext context,
  }) async {
    TimeOfDay initTime = TimeOfDay.now();

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initTime,
    );

    DateTime tempDate = DateFormat("HH:mm")
        .parse("${selectedTime!.hour}:${selectedTime.minute}");
    var dateFormat = DateFormat("HH:mm"); // you can change the format here

    return dateFormat.format(tempDate);
  }
}
