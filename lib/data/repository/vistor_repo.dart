import 'package:igt_e_pass_app/data/model/selected_item_model.dart';
import 'package:igt_e_pass_app/data/model/vistor/vistors_model.dart';
import 'package:igt_e_pass_app/data/network/base_api_service.dart';
import 'package:igt_e_pass_app/data/network/network_api_service.dart';
import 'package:igt_e_pass_app/resource/app_url.dart';
import 'package:igt_e_pass_app/resource/constant.dart';
import '../model/response_model.dart';
import '../model/vistor/visitor_checkout_model.dart';
import '../model/vistor/visitor_preview_model.dart';

class VisitorRepo {
  BaseApiService apiService = NetworkApiService();

  Future<VisitorsModel> getVistor(
      {String? query, String? page, String? limit}) async {
    var response = await apiService.get(
        url:
            "${AppUrl.vistorUrl}?start=$page&limit=$limit&query=${query ?? ''}");
    return VisitorsModel.fromJson(response);
  }

  Future<VisitorsPreviewModel> getVistorPreview(String id) async {
    var response = await apiService.get(url: "${AppUrl.vistorPreviewUrl}$id");
    return VisitorsPreviewModel.fromJson(response);
  }

  Future<VisitorCheckoutModel> getVistorCheckoutInfo({String? code}) async {
    var response = await apiService.get(
        endpoint: AppUrl.visitorCheckoutEndpoint,
        queryParameters: {"code": code});
    return VisitorCheckoutModel.fromJson(response);
  }

  Future<VisitorCheckoutModel> getVistorCheckInInfo({String? code}) async {
    var response = await apiService.get(
        endpoint: AppUrl.visitorCheckInEndpoint,
        queryParameters: {"code": code});
    return VisitorCheckoutModel.fromJson(response);
  }

  Future<ResponseModel> registerNewVisitor(
      {String? file, Map<String, String>? params}) async {
    var response = await apiService.postMultipart(
        keyValue: Const.empFile,
        filePath: file,
        url: AppUrl.registerNewVistorUrl,
        params: params ?? {});
    return ResponseModel.fromJson(response);
  }

  Future<ResponseModel> allowVisitor(Map<String, String> params) async {
    var response = await apiService.post(url: AppUrl.allowedUrl, data: params);
    return ResponseModel.fromJson(response);
  }

  Future<List<SelectedItemModel>> getCardNo(
      {String? page, String? limit, String? query}) async {
    var response = await apiService.get(
        url:
            "${AppUrl.cardNoUrl}?start=$page&limit=$limit&query=${query ?? ''}");
    return List.from(response['data'])
        .map((e) => SelectedItemModel.fromJson(e))
        .toList();
  }

  Future<AllowedModel> getAllowed(String id) async {
    var response = await apiService.get(url: AppUrl.getAllowedUrl + id);
    return AllowedModel.fromJson(response);
  }

  Future<VisitorsModel> getHistoryVisitor(
      {String? query, String? page, String? limit}) async {
    var response = await apiService.get(
        url:
            "${AppUrl.historyVisitorUrl}?start=$page&limit=$limit&query=${query ?? ''}");
    return VisitorsModel.fromJson(response);
  }
}
