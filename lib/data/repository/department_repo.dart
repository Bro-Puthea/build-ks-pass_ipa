import 'package:igt_e_pass_app/data/network/base_api_service.dart';
import 'package:igt_e_pass_app/data/network/network_api_service.dart';
import 'package:igt_e_pass_app/resource/app_url.dart';

import '../model/pre_register/department_model.dart';

class DepartmentRepo {
  
  BaseApiService apiService = NetworkApiService();

  Future<DepartmentModel> getDepartment() async {
    var response = await apiService.get(url: AppUrl.departmentUrl);
    return DepartmentModel.fromJson(response);
  }
}