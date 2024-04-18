import 'package:get_it/get_it.dart';
import 'package:recipe_book/services/definitions/auth_service.dart';
import 'package:recipe_book/services/definitions/data_service.dart';
import 'package:recipe_book/services/implementations/default_auth_service.dart';
import 'package:recipe_book/services/implementations/default_data_service.dart';
import 'package:recipe_book/services/implementations/default_http_service.dart';

import 'services/definitions/http_service.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<HttpService>(() => DefaultHttpService());
  getIt.registerLazySingleton<AuthService>(() => DefaultAuthService());
  getIt.registerLazySingleton<DataService>(() => DefaultDataService());
}