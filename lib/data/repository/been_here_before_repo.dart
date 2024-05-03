import 'package:igt_e_pass_app/data/network/base_api_service.dart';
import 'package:igt_e_pass_app/data/network/network_api_service.dart';
import 'package:igt_e_pass_app/resource/app_url.dart';

import '../model/vistor/visitor_checkout_model.dart';

class BeenHereBeforRepo {
  
  BaseApiService apiService = NetworkApiService();

  Future<VisitorCheckoutModel> checkBeenHereBefore({String? phone}) async {
    var response = await apiService.get(endpoint: AppUrl.beenHereBeforeEndpoint, 
    queryParameters: {
      "phone" : phone
    });
    return VisitorCheckoutModel.fromJson(response);
  }

}