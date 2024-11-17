import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RecipesProvider>(
        builder: (context, recipeProvider, child) {
          final favoritesRecipes = recipeProvider.favoriteRecipes;

          return (favoritesRecipes.isEmpty)
              ? Center(child: Text(AppLocalizations.of(context)!.noRecipes))
              : ListView.builder(
                  itemCount: favoritesRecipes.length,
                  itemBuilder: (context, index) {
                    return FavoriteRecipesCard(recipe: favoritesRecipes[index]);
                  },
                );
        },
      ),
    );
  }
}

class FavoriteRecipesCard extends StatelessWidget {
  const FavoriteRecipesCard({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(recipesData: recipe),
            ));
      },
      child: Semantics(
        label: "Tarjeta de recetas",
        hint: "Toca para ver detalle de receta ${recipe.name}",
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.network(
                  recipe.imageLink,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                recipe.name,
                style: const TextStyle(
                  color: Colors.orange,
                  fontFamily: "Quicsand",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Text(recipe.author),
            ],
          ),
        ),
      ),
    );
  }
}
