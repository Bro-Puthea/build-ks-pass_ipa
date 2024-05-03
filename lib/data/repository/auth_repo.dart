import 'package:igt_e_pass_app/data/model/response_model.dart';
import 'package:igt_e_pass_app/data/model/user_login_model.dart';
import 'package:igt_e_pass_app/data/network/base_api_service.dart';
import 'package:igt_e_pass_app/data/network/network_api_service.dart';
import 'package:igt_e_pass_app/resource/app_url.dart';
import 'package:igt_e_pass_app/resource/constant.dart';
import 'package:igt_e_pass_app/utils/storage_utils.dart';

class AuthRepo {
  BaseApiService apiService = NetworkApiService();

  Future<UserLoginModel> doLogin(Map<String, dynamic> params) async {
    var response = await apiService.post(url: AppUrl.loginUrl, data: params);
    return UserLoginModel.fromJson(response);
  }

  Future<UserLoginModel> getProfilePreview() async {
    var response = await apiService.get(url: AppUrl.profileUrl);
    return UserLoginModel.fromJson(response);
  }

  Future<ResponseModel> updateProfile(Map<String, dynamic> params) async {
    var response =
        await apiService.post(url: AppUrl.updateProfileUrl, data: params);
    return ResponseModel.fromJson(response);
  }

  Future<ResponseModel> doChangePassword(Map<String, dynamic> params) async {
    var response =
        await apiService.post(url: AppUrl.changPasswordUrl, data: params);
    return ResponseModel.fromJson(response);
  }

  Future<ResponseModel> updateProfilePic({String? filePath}) async {
    var response = await apiService.postMultipart(
        filePath: filePath,
        keyValue: "avatar",
        url: AppUrl.updateProfilePictureUrl);
    return ResponseModel.fromJson(response);
  }
}
