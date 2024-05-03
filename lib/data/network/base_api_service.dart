abstract class BaseApiService {
  Future<dynamic> get(
    {
      String? url,
      String? endpoint,
      Map<String, dynamic>? queryParameters, });
  Future<dynamic> post({String url,Object? data});
  Future<dynamic> put({String url,Object? data});
  Future<dynamic> delete({String url});
  Future<dynamic> postMultipart(
    {String? url,
    String? keyValue, 
    String? filePath,
    Map<String, String> params});
}