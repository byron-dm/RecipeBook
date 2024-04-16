import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;

  const RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white60,
          title: Text(AppLocalizations.of(context)!.appTitle)),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          _recipeDetails(context),
          _recipeIngredients(context),
          _recipeInstructions(context)
        ],
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.4,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(recipe.image))),
    );
  }

  Widget _recipeDetails(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${recipe.cuisine}, ${recipe.difficulty}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          Text(recipe.name,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Text(
            "${AppLocalizations.of(context)!.recipePagePrepTime}: ${recipe.prepTimeMinutes} ${AppLocalizations.of(context)!.recipePageMinutes} | ${AppLocalizations.of(context)!.recipePageCookTime}: ${recipe.cookTimeMinutes} ${AppLocalizations.of(context)!.recipePageMinutes}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
          Text(
            "${recipe.rating.toString()} ⭐ | ${AppLocalizations.of(context)!.recipePageReviews(recipe.reviewCount)}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _recipeIngredients(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Column(
        children: recipe.ingredients.map((ingredient) {
          return Row(children: [
            const Icon(Icons.check_box),
            Text(" $ingredient", style: const TextStyle(fontSize: 15))
          ]);
        }).toList(),
      ),
    );
  }

  Widget _recipeInstructions(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: recipe.instructions.map((instruction) {
          return Text(
            "${recipe.instructions.indexOf(instruction) + 1}. $instruction\n",
            maxLines: 3,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 15.0),
          );
        }).toList(),
      ),
    );
  }
}
