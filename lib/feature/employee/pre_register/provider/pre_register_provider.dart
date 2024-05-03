import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/pre_register/view_pre_register_model.dart';
import 'package:igt_e_pass_app/data/model/response_model.dart';
import 'package:igt_e_pass_app/data/model/selected_item_model.dart';
import 'package:igt_e_pass_app/data/repository/pre_register_repo.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../data/model/pre_register/pre_register_model.dart';

class PreRegisterProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final repo = PreRegisterRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  List<PreRegisters> list = [];
  List<SelectedItemModel> selectedCard = [];
  List<SelectedItemModel> notifyTo = [];
  AppointmentInfoModel registerModel = AppointmentInfoModel();
  ResponseModel responseStatus = ResponseModel();
  int page = 1;
  int limit = 10;
  int total = 0;

  PreRegisterProvider() {
    initData();
  }

  Future initData({String? query}) async {
    page = 1;
    setLoading(true);
    await repo
        .getPreRegister(query: query, limit: "$limit", page: "$page")
        .then((res) async {
      setLoading(false);
      list = res.data!;
      total = res.total!;
      list.isEmpty ? isEmpty = true : isEmpty = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      debugPrint(">>>>>>>>>>>>>>>>>$stackTrace");
    });
  }

  Future loadMoreData({String? query}) async {
    page += limit;
    debugPrint(">>>>>>>>>>>>>>>>>$page");
    await repo
        .getPreRegister(query: query, limit: "$limit", page: "$page")
        .then((res) async {
      list += res.data ?? [];
      if (res.data!.length == total) {
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      debugPrint(">>>>>>>>>>>>>>>>>$error");
    });
  }

  Future addData(Map<String, dynamic> params) async {
    print('-----> $params');
    setLoading(true);
    await repo.addPreRegister(params).then((res) async {
      setLoading(false);
      responseStatus = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      debugPrint(">>>>>>>>>>>>>>>..Add: ${error.toString()}");
    });
  }

  Future updateData(String params, String id) async {
    print('-----> $params');
    setLoading(true);
    await repo.updatePreRegister(params, id).then((res) async {
      setLoading(false);
      responseStatus = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      debugPrint(">>>>>>>>>>>>>>>..Add: ${stackTrace.toString()}");
    });
  }

  Future deleteData(String id) async {
    setLoading(true);
    await repo.deletPreRegister(id).then((res) async {
      setLoading(false);
      responseStatus = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future cancel(String id) async {
    setLoading(true);
    await repo.cancelAppointment(id).then((res) async {
      setLoading(false);
      responseStatus = res;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future refreshData() async {
    await repo
        .getPreRegister(limit: "$limit", page: "1", query: "")
        .then((res) async {
      list = res.data!;
      total = res.total!;
      list.isEmpty ? isEmpty = true : isEmpty = false;
      notifyListeners();
    }).onError((error, stackTrace) {});
  }

  //Preview
  Future initPreviewData(String id) async {
    setLoading(true);
    await repo.getPreRegisterPreview(id).then((res) async {
      setLoading(false);
      registerModel = res.data ?? AppointmentInfoModel();
      selectedCard = res.cardId ?? [];
      notifyTo = res.notify ?? [];
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future refreshPreviewData(String id) async {
    await repo.getPreRegisterPreview(id).then((res) async {
      registerModel = res.data ?? AppointmentInfoModel();
      selectedCard = res.cardId ?? [];
      notifyTo = res.notify ?? [];
      notifyListeners();
    }).onError((error, stackTrace) {});
  }
}
