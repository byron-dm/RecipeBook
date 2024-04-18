import 'package:logger/logger.dart';
import 'package:recipe_book/services/definitions/auth_service.dart';
import 'package:recipe_book/services/definitions/http_service.dart';

import '../../injection_container.dart';
import '../../models/user.dart';

class DefaultAuthService implements AuthService {

  final _httpService = getIt<HttpService>();
  final _logger = Logger();

  User? user;

  @override
  Future<bool> login(String username, String password) async {
    try {
      _httpService.setup(null);
      var response = await _httpService.post("auth/login", {
        "username": username,
        "password": password
      });

      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response!.data);
        _httpService.setup(user!.token);
        return true;
      }
    } catch (exception) {
      _logger.e(exception);
    }

    return false;
  }
}