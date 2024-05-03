import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:igt_e_pass_app/data/error/app_exception.dart';
import 'package:igt_e_pass_app/data/network/base_api_service.dart';
import '../../resource/app_url.dart';
import '../../resource/constant.dart';
import '../../utils/storage_utils.dart';

class NetworkApiService extends BaseApiService {
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(message: response.body.toString());
      case 401:
        throw UnAuthorizedException(message: response.body.toString());
      case 500:
        throw FetchDataException(message: "Somthinge when wrong");
      default:
        throw FetchDataException(message: "Something went wrong");
    }
  }

  @override
  Future get({
    String? url,
    String? endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    dynamic responseJson;
    try {
      http.Response response = await http.get(
          url != null
              ? Uri.parse(url)
              : Uri.https(
                  AppUrl.url, "${AppUrl.apiVersion}$endpoint", queryParameters),
          headers: {
            Const.apiKey: AppUrl.apiKey,
            Const.userId: await getUserId(),
            Const.lang: await getLangCode(),
          }).timeout(const Duration(seconds: 30));
      print(
          'URL==> ${response.request?.url}\n Head${response.request?.headers}');
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "Somthinge when wrong");
    }

    return responseJson;
  }

  @override
  Future post({String? url, Object? data}) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .post(Uri.parse(url ?? ''),
              headers: {
                Const.apiKey: AppUrl.apiKey,
                Const.userId: await getUserId(),
                Const.lang: await getLangCode(),
              },
              body: data)
          .timeout(const Duration(seconds: 30));
      print(
          'URL==> ${response.request?.url}\n Head${response.request?.headers}');
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "Somthinge when wrong");
    }
    return responseJson;
  }

  @override
  Future postMultipart(
      {String? url,
      String? keyValue,
      String? filePath,
      Map<String, String>? params}) async {
    dynamic responseJson;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url ?? ''));
      request.headers.addAll({
        Const.apiKey: AppUrl.apiKey,
        Const.userId: await getUserId(),
        Const.lang: await getLangCode(),
      });
      request.fields.addAll(params ?? {});
      filePath != null
          ? request.files.add(
              await http.MultipartFile.fromPath(keyValue ?? '', filePath ?? ''))
          : request.fields[keyValue ?? ''] = '';

      var response = await request.send().timeout(const Duration(seconds: 60));
      var responded = await http.Response.fromStream(response);
      print(
          'URL==> ${response.request?.url}\n Head${response.request?.headers}');
      responseJson = returnResponse(responded);
    } on SocketException {
      throw FetchDataException(message: "Somthing when wrong");
    }
    return responseJson;
  }

  @override
  Future delete({
    String? url,
  }) async {
    dynamic responseJson;
    try {
      http.Response response =
          await http.delete(Uri.parse(url ?? ''), headers: {
        Const.apiKey: AppUrl.apiKey,
        Const.userId: await getUserId(),
        Const.lang: await getLangCode(),
      }).timeout(const Duration(seconds: 30));
      print(
          'URL==> ${response.request?.url}\n Head${response.request?.headers}');
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "Somthinge when wrong");
    }

    return responseJson;
  }

  @override
  Future put({String? url, Object? data}) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .put(Uri.parse(url ?? ''),
              headers: {
                Const.apiKey: AppUrl.apiKey,
                Const.userId: await getUserId(),
                Const.lang: await getLangCode(),
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: data)
          .timeout(const Duration(seconds: 30));
      print(
          'URL==> ${response.request?.url}\n Head${response.request?.headers}');
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "Somthinge when wrong");
    }
    return responseJson;
  }
}
