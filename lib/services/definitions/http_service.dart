import 'package:dio/dio.dart';

abstract class HttpService {

  Future<void> setup(String? bearerToken);

  Future<Response?> get(String path);

  Future<Response?> post(String path, Map data);
}