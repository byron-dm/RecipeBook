import '../models/user.dart';
import 'http_service.dart';

class AuthService {

  static final AuthService _instance = AuthService._internal();

  final _httpService = HttpService();

  User? user;

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  Future<bool> login(String username, String password) async {
    try {
      var response = await _httpService.post("auth/login", {
        "username": username,
        "password": password
      });

      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response!.data);
        HttpService().setup(user!.token);
        return true;
      }
    } catch (exception) {
      print(exception);
    }

    return false;
  }
}