import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/vistor/visitor_checkout_model.dart';
import 'package:igt_e_pass_app/data/repository/vistor_repo.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';

class VistorCheckInProvider with ChangeNotifier {
  final repo = VisitorRepo();

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  VisitorCheckoutModel visitorCheckin = VisitorCheckoutModel();

  VistorCheckInProvider() {
    //initData();
  }

  Future initData({String? code}) async {
    setLoading(true);
    await repo.getVistorCheckInInfo(code: code).then((res) async {
      setLoading(false);
      visitorCheckin = res;
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>Respone ${visitorCheckin.toJson()}");
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }
}
