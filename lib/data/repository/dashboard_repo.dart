import 'package:igt_e_pass_app/data/model/dashboard_model.dart';
import 'package:igt_e_pass_app/data/network/base_api_service.dart';
import 'package:igt_e_pass_app/data/network/network_api_service.dart';
import 'package:igt_e_pass_app/resource/app_url.dart';

class DashboardRepo {
  
  BaseApiService apiService = NetworkApiService();

  Future<DashboardModel> getDashboard() async {
    var response = await apiService.get(url: AppUrl.dashboardUrl);
    return DashboardModel.fromJson(response);
  }

}