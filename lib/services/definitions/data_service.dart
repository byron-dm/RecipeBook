import '../../models/recipe.dart';

abstract class DataService {

  Future<List<Recipe>> getRecipes(String filter);
}