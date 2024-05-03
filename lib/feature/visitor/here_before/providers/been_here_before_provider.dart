import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/vistor/visitor_checkout_model.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import '../../../../data/repository/been_here_before_repo.dart';

class BeenHereBeforProvider with ChangeNotifier {

  final repo = BeenHereBeforRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  VisitorCheckoutModel beenHereBeforData = VisitorCheckoutModel();

  BeenHereBeforProvider() {
    //initData();
  }

  Future initData({String? phone}) async {
    setLoading(true);
    await repo.checkBeenHereBefore(phone: phone).then((res) async {
      setLoading(false);
      beenHereBeforData = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }
}
