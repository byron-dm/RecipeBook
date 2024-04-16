import 'package:dio/dio.dart';
import 'package:recipe_book/constants.dart';

class HttpService {

  static final HttpService _instance = HttpService._internal();

  final _dio = Dio();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal() {
    setup(null);
  }

  Future<void> setup(String? bearerToken) async {
    final headers = {
      "Content-Type": "application/json"
    };

    if (bearerToken != null) {
      headers["Authorization"] = "Bearer $bearerToken";
    }

    final options = BaseOptions(
      baseUrl: API_BASE_URL,
      headers: headers,
      validateStatus: (status) {
        return status == null ? false : status < 500;
      }
    );

    _dio.options = options;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      return await _dio.post(path, data: data);
    } catch (exception) {
      print(exception);
    }

    return null;
  }

  Future<Response?> get(String path) async {
    try {
      return await _dio.get(path);
    } catch (exception) {
      print(exception);
    }

    return null;
  }
}