import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:recipe_book/providers/recipes_provider.dart';

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
              ? const Center(child: Text("No favorite recipes."))
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
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(recipe.name),
            Text(recipe.author),
          ],
        ),
      ),
    );
  }
}
