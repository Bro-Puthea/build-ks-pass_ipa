import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/dashboard_model.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import '../../../../data/model/vistor/vistors_model.dart';
import '../../../../data/repository/dashboard_repo.dart';

class DashboardProvider with ChangeNotifier {
  final repo = DashboardRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }

  DashboardModel data = DashboardModel();
  List<Visitors> list = [];

  DashboardProvider() {
    initData();
  }

  Future initData() async {
    setLoading(true);
    await repo.getDashboard().then((res) async {
      setLoading(false);
      data = res;
      list = res.visitors ?? [];
      list.isEmpty ? isEmpty = true : isEmpty = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      print(stackTrace.toString());
    });
  }
}
