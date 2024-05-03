import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/data/model/vistor/visitor_checkout_model.dart';
import 'package:igt_e_pass_app/feature/visitor/checkin/waiting_confirm_page.dart';
import 'package:igt_e_pass_app/resource/app_url.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../utils/my_navigator.dart';

Future<void> initOneSignal() async {
  await OneSignal.shared.setAppId(AppUrl.oneSignalAppId).then((_) async {
    await OneSignal.shared.getDeviceState().then((status) async {
      if (status!.userId != null) {
        setPlayerId(status.userId ?? "");
      }
      print('playerId ==> ${status.userId}');
      await OneSignal.shared
          .promptUserForPushNotificationPermission(fallbackToSettings: false);
    });
  });
}

void openHandlerOneSignal(BuildContext context) {
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    var encode = jsonEncode(result.notification.additionalData);
    var res = json.decode(encode);
    String name = res['name'].toString();
    String phone = res['phone'].toString();
    String image = res['image'].toString();
    String code = res['visitor_code'].toString();
    String id = res['visitor_id'].toString();
    String empName = res['emp_name'].toString();
    String allow = res['allowed'].toString();
    String allowBy = res['allow_by'].toString();
    print('notification data  ==> $res');

    Nav.push(
        WaitingConfirmPage(
            data: DataCheckIn(
                isSecurity: false,
                visitorName: name,
                phone: phone,
                image: image,
                empName: empName,
                visitorCode: code,
                id: id,
                allowed: allow,
                allowBy: allowBy)),
        context: context);
  });
}
