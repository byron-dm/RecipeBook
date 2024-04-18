import 'package:dio/dio.dart';
import 'package:recipe_book/constants.dart';
import 'package:recipe_book/services/definitions/http_service.dart';

class DefaultHttpService implements HttpService {

  final _dio = Dio();

  @override
  Future<void> setup(String? bearerToken) async {
    final headers = {
      "Content-Type": "application/json"
    };

    if (bearerToken != null) {
      headers["Authorization"] = "Bearer $bearerToken";
    }

    final options = BaseOptions(
      baseUrl: apiBaseUrl,
      headers: headers,
      validateStatus: (status) {
        return status == null ? false : status < 500;
      }
    );

    _dio.options = options;
  }

  @override
  Future<Response?> get(String path) async {
    try {
      return await _dio.get(path);
    } catch (exception) {
      print(exception);
    }

    return null;
  }

  @override
  Future<Response?> post(String path, Map data) async {
    try {
      return await _dio.post(path, data: data);
    } catch (exception) {
      print(exception);
    }

    return null;
  }
}