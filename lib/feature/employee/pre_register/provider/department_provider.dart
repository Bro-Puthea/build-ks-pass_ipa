import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:igt_e_pass_app/data/model/selected_item_model.dart';
import 'package:igt_e_pass_app/data/repository/department_repo.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';


class DepartmentProvider with ChangeNotifier{

  final repo = DepartmentRepo();
  bool isEmpty = false;

  setLoading(bool value) {
    GeneralUtil.showLoading();
    value ? EasyLoading.show(status: 'Loading') : EasyLoading.dismiss();
  }
  List<SelectedItemModel> departmentList = [];

  DepartmentProvider(){
    initData();
  }

  Future initData() async {
    setLoading(true);
    await repo.getDepartment().then((res) async {
      setLoading(false);
      for(var i in res.departments!){
        departmentList.add(
          SelectedItemModel(id: i.id, name: i.name)
        );
      }
      notifyListeners();
    }).onError((error, stackTrace) {
  setLoading(false);
    });
  }
}