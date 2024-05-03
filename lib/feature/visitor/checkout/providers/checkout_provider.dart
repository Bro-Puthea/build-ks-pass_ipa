import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/vistor/visitor_checkout_model.dart';
import 'package:igt_e_pass_app/data/repository/vistor_repo.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';

class VistorCheckoutProvider with ChangeNotifier {
  final repo = VisitorRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  VisitorCheckoutModel visitorCheckout = VisitorCheckoutModel();

  VistorCheckoutProvider() {
    //initData();
  }

  Future initData({String? code}) async {
    setLoading(true);
    await repo.getVistorCheckoutInfo(code: code).then((res) async {
      setLoading(false);
      visitorCheckout = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }
}
