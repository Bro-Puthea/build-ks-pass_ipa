import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/response_model.dart';
import 'package:igt_e_pass_app/data/repository/vistor_repo.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';
import '../../../../data/model/vistor/visitor_preview_model.dart';
import '../../../../data/model/vistor/vistors_model.dart';
import '../../../../resource/constant.dart';

class CheckinProvider with ChangeNotifier {
  final repo = VisitorRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  ResponseModel resultResponse = ResponseModel();
  VisitorsPreviewModel data = VisitorsPreviewModel();
  AllowedModel allow = AllowedModel();

  CheckinProvider() {
    //
  }

  Future registerNewVisitor({String? file, Map<String, String>? params}) async {
    setLoading(true);
    if (Const.isDebug) print('------ params: $params');
    await repo.registerNewVisitor(file: file, params: params).then((res) async {
      setLoading(false);
      resultResponse = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future toAllowIn(String id) async {
    setLoading(true);
    Map<String, String> params = {
      Const.allowed: '1',
      Const.allowBy: await getUserId(),
      Const.visitorId: id
    };
    if (Const.isDebug) print('------ params: $params');
    await repo.allowVisitor(params).then((res) async {
      setLoading(false);
      resultResponse = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future info(String id) async {
    await repo.getVistorPreview(id).then((res) async {
      data = res;
      notifyListeners();
    }).onError((error, stackTrace) {});
  }

  Future getAllowed(String id) async {
    await repo.getAllowed(id).then((res) async {
      allow = res;
      notifyListeners();
    }).onError((error, stackTrace) {});
  }
}
