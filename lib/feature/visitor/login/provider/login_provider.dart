import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/config/init_onesignal.dart';
import 'package:igt_e_pass_app/data/model/user_login_model.dart';
import 'package:igt_e_pass_app/data/repository/auth_repo.dart';
import 'package:igt_e_pass_app/resource/constant.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';

class LoginProvider with ChangeNotifier {
  final repo = AuthRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  UserLoginModel userData = UserLoginModel();

  LoginProvider() {
    initOneSignal();
    //initData();
  }

  Future doLogin({String? identity, String? password}) async {
    setLoading(true);
    var params = {
      Const.identity: identity,
      Const.password: password,
      Const.playerId: await getPlayerId()
    };

    print('----- $params');
    await repo.doLogin(params).then((res) async {
      setLoading(false);
      userData = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      print(">>>>>>>> $error");
      setLoading(false);
    });
  }
}
