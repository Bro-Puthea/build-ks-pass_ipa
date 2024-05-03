import 'package:igt_e_pass_app/data/network/base_api_service.dart';
import 'package:igt_e_pass_app/data/network/network_api_service.dart';

class SampleRepo {
  
  BaseApiService apiService = NetworkApiService();

  Future<dynamic> getBankDashBoard() async {
    var response = await apiService.get(url: '');
    //return Data.fromJson(response);
  }

}