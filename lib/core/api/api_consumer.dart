abstract class ApiConsumer {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String url, {dynamic data});
  Future<dynamic> put(String url, {dynamic data});
  Future<dynamic> patch(String url, {dynamic data});
  Future<dynamic> delete(String url);
}
