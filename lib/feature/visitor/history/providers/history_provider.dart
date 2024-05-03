import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/vistor/visitor_preview_model.dart';
import 'package:igt_e_pass_app/data/model/vistor/vistors_model.dart';
import 'package:igt_e_pass_app/data/repository/vistor_repo.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final repo = VisitorRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  List<Visitors> list = [];

  int page = 1;
  int limit = 10;
  int total = 0;

  HistoryProvider() {
    initData();
  }

  Future initData({String? query}) async {
    page = 1;
    setLoading(true);
    await repo
        .getHistoryVisitor(query: query, limit: "$limit", page: "$page")
        .then((res) async {
      setLoading(false);
      list = res.data ?? [];
      total = res.total!;
      list.isNotEmpty ? isEmpty = false : isEmpty = true;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      print(">>>>>>>>>>>>>>>>>$stackTrace");
    });
  }

  Future loadMoreData({String? query}) async {
    page += limit;
    await repo
        .getHistoryVisitor(query: query, limit: "$limit", page: "$page")
        .then((res) async {
      list += res.data ?? [];
      if (res.data!.length == total) {
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      print(">>>>>>>>>>>>>>>>>$error");
    });
  }

  Future refreshData() async {
    page = 1;
    refreshController.resetNoData();
    await repo.getHistoryVisitor().then((res) async {
      list = res.data!;
      list.isNotEmpty ? isEmpty = false : isEmpty = true;
      notifyListeners();
    }).onError((error, stackTrace) {});
  }
}
