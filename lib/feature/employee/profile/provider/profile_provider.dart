import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/response_model.dart';
import 'package:igt_e_pass_app/data/model/user_login_model.dart';
import 'package:igt_e_pass_app/data/repository/auth_repo.dart';
import 'package:igt_e_pass_app/resource/constant.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';
import 'package:path/path.dart';

class ProfileProvider with ChangeNotifier {
  final repo = AuthRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  ResponseModel responeState = ResponseModel();
  User userData = User();

  ProfileProvider() {
    getProfilePreview();
  }

  Future getProfilePreview() async {
    //setLoading(true);
    await repo.getProfilePreview().then((res) async {
      //setLoading(false);
      userData = res.data!;
      notifyListeners();
    }).onError((error, stackTrace) {
      print(">>>>>>>> $stackTrace");
      //setLoading(false);
    });
  }

  Future updateProfile(Map<String, dynamic> params) async {
    print('---> $params');
    setLoading(true);
    await repo.updateProfile(params).then((res) async {
      setLoading(false);
      responeState = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      print(">>>>>>>> $stackTrace");
      setLoading(false);
    });
  }

  Future updateProfilePic({String? filePath}) async {
    setLoading(true);
    await repo.updateProfilePic(filePath: filePath).then((res) async {
      setLoading(false);
      responeState = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      print(">>>>>>>> $stackTrace");
      print(">>>>>>>> $error");
      setLoading(false);
    });
  }

  Future doChangePassword(
      {String? currentPassword,
      String? newPassword,
      String? newConfirmPassword}) async {
    setLoading(true);
    var params = {
      Const.currentPassword: currentPassword ?? '',
      Const.newPassword: newPassword ?? '',
      Const.newConfirmPassword: newConfirmPassword ?? ''
    };
    await repo.doChangePassword(params).then((res) async {
      setLoading(false);
      responeState = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      print(">>>>>>>> $error");
      setLoading(false);
    });
  }
}
