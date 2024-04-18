import 'package:flutter/material.dart';
import 'package:recipe_book/pages/recipe_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipe_book/services/definitions/data_service.dart';

import '../injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _mealTypeFilter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        centerTitle: true,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _recipeTypeButtons(),
          _recipesList(),
        ],
      ),
    );
  }

  Widget _recipeTypeButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.03,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  onPressed: () {
                    setState(() {
                      _mealTypeFilter = "snack";
                    });
                  },
                  child: const Text("Snack"))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  onPressed: () {
                    setState(() {
                      _mealTypeFilter = "breakfast";
                    });
                  },
                  child: const Text("Breakfast"))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  onPressed: () {
                    setState(() {
                      _mealTypeFilter = "lunch";
                    });
                  },
                  child: const Text("Lunch"))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  onPressed: () {
                    setState(() {
                      _mealTypeFilter = "dinner";
                    });
                  },
                  child: const Text("Dinner")))
        ],
      ),
    );
  }

  Widget _recipesList() {
    return Expanded(
        child: FutureBuilder(
      future: getIt<DataService>().getRecipes(_mealTypeFilter),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
              child: Text(AppLocalizations.of(context)!.homePageError));
        }
        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var recipe = snapshot.data![index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return RecipePage(recipe: recipe);
                    }),
                  );
                },
                contentPadding: const EdgeInsets.only(top: 20),
                leading: Image.network(recipe.image),
                isThreeLine: true,
                subtitle: Text(
                    "${recipe.cuisine}\n${AppLocalizations.of(context)!.homePageDifficulty}: ${recipe.difficulty}"),
                title: Text(recipe.name),
                trailing: Text("${recipe.rating} ⭐",
                    style: const TextStyle(fontSize: 15)),
              );
            });
      },
    ));
  }
}
