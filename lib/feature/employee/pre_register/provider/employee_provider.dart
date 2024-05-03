import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/selected_item_model.dart';
import 'package:igt_e_pass_app/data/repository/employee_repo.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmployeeProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final repo = EmployeeRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  int page = 1;
  int limit = 10;
  int total = 0;
  List<SelectedItemModel> employeeList = [];
  List<SelectedItemModel> item = [];

  EmployeeProvider() {
    //initData();
  }

  Future initData({String? query, String? departmentId}) async {
    setLoading(true);
    item.clear();
    await repo
        .getEmployees(
            query: query,
            limit: "$limit",
            page: "$page",
            departmentId: "$departmentId")
        .then((res) async {
      setLoading(false);
      for (var i in res.employees!) {
        item.add(SelectedItemModel(id: i.id, name: i.fullName));
      }
      employeeList = item;
      print(">>>>>>>>>>>>>>>>>${res.toJson()}");
      total = res.total!;
      employeeList.isEmpty ? isEmpty = true : isEmpty = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future loadMoreData({String? query, String? departmentId}) async {
    page += limit;
    //item.clear();
    await repo
        .getEmployees(
            query: query,
            limit: "$limit",
            page: "$page",
            departmentId: departmentId)
        .then((res) async {
      for (var i in res.employees!) {
        item.add(SelectedItemModel(id: i.id, name: i.fullName));
      }
      employeeList += item;
      if (employeeList.length <= total) {
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
    item.clear();
    await repo
        .getEmployees(limit: "$limit", page: "1", query: "", departmentId: '')
        .then((res) async {
      for (var i in res.employees!) {
        item.add(SelectedItemModel(id: i.id, name: i.fullName));
      }
      employeeList = item;
      total = res.total!;
      employeeList.isEmpty ? isEmpty = true : isEmpty = false;
      notifyListeners();
    }).onError((error, stackTrace) {});
  }
}
