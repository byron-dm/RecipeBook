import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/services/definitions/data_service.dart';
import 'package:recipe_book/services/definitions/http_service.dart';

import '../../injection_container.dart';

class DefaultDataService implements DataService {

  final HttpService _httpService = getIt<HttpService>();

  @override
  Future<List<Recipe>> getRecipes(String filter) async {
    String path = "recipes/";

    if (filter.isNotEmpty) {
      path += "meal-type/$filter";
    }

    var response = await _httpService.get(path);

    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];
      return data
          .map((jsonRecipe) => Recipe.fromJson(jsonRecipe))
          .toList();
    }

    return [];
  }
}
