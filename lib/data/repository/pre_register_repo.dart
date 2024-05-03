import 'package:igt_e_pass_app/data/network/base_api_service.dart';
import 'package:igt_e_pass_app/data/network/network_api_service.dart';
import 'package:igt_e_pass_app/resource/app_url.dart';

import '../model/pre_register/pre_register_model.dart';
import '../model/pre_register/view_pre_register_model.dart';
import '../model/response_model.dart';

class PreRegisterRepo {
  BaseApiService apiService = NetworkApiService();

  Future<AllPreRegisterModel> getPreRegister(
      {String? query, String? page, String? limit}) async {
    var response = await apiService.get(
        url:
            "${AppUrl.preRegisterUrl}?start=$page&limit=$limit&query_name=${query ?? ''}");
    return AllPreRegisterModel.fromJson(response);
  }

  Future<ViewPreRegisterModel> getPreRegisterPreview(String id) async {
    var response =
        await apiService.get(url: "${AppUrl.preRegisterPreviewUrl}$id");
    return ViewPreRegisterModel.fromJson(response);
  }

  Future<ResponseModel> addPreRegister(Map<String, dynamic> params) async {
    var response = await apiService.post(
      url: AppUrl.addPreRegisterUrl,
      data: params,
    );
    return ResponseModel.fromJson(response);
  }

  Future<ResponseModel> updatePreRegister(String params, String id) async {
    var response = await apiService.put(
        url: "${AppUrl.updatePreRegisterUrl}$id", data: params);
    return ResponseModel.fromJson(response);
  }

  Future<ResponseModel> deletPreRegister(String id) async {
    var response = await apiService.delete(
      url: "${AppUrl.deleteRegisterUrl}$id",
    );
    return ResponseModel.fromJson(response);
  }

  Future<ResponseModel> cancelAppointment(String id) async {
    var response = await apiService.get(url: AppUrl.cancelRegisterUrl + id);
    return ResponseModel.fromJson(response);
  }
}
