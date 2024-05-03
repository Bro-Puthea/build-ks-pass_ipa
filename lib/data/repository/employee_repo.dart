import 'package:igt_e_pass_app/data/model/employee_model.dart';
import 'package:igt_e_pass_app/data/network/base_api_service.dart';
import 'package:igt_e_pass_app/data/network/network_api_service.dart';
import 'package:igt_e_pass_app/resource/app_url.dart';

class EmployeeRepo {
  
  BaseApiService apiService = NetworkApiService();

  Future<EmployeesModel> getEmployees( {
      String? query,
      String? page,
      String? limit,
      String? departmentId
    }) async {
    var response = await apiService
    .get(url: "${AppUrl.employeesUrl}?department_id=$departmentId&start=$page&limit=$limit&query_name=${query ?? ''}");
    return EmployeesModel.fromJson(response);
  }
}