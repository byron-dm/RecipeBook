import 'package:recipe_book/models/recipe.dart';

import 'http_service.dart';

class DataService {
  static final DataService _instance = DataService._internal();

  final _httpService = HttpService();

  factory DataService() {
    return _instance;
  }

  DataService._internal();

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
