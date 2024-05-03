import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/selected_item_model.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../data/repository/vistor_repo.dart';

class CardNoProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final repo = VisitorRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  int page = 1;
  int limit = 10;
  int total = 0;
  List<SelectedItemModel> item = [];

  CardNoProvider() {
    initData();
  }

  Future initData({String? query, String? departmentId}) async {
    setLoading(true);
    item.clear();
    await repo
        .getCardNo(query: query, limit: "$limit", page: "$page")
        .then((res) async {
      setLoading(false);
      item = res;
      item.isEmpty ? isEmpty = true : isEmpty = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future loadMoreData({String? query, String? departmentId}) async {
    page += limit;
    // item.clear();
    await repo
        .getCardNo(query: query, limit: "$limit", page: "$page")
        .then((res) async {
      item += res;
      if (item.length <= total) {
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      print(">>>>>>>>>>>>>>>>>$error");
    });
  }
}
