import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recipe_book/models/recipe_model.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<RecipeModel> recipes = [];
  List<RecipeModel> favoriteRecipes = [];

  // Android 10.0.2.2
  // IOS 127.0.0.1
  Future<void> fetchRecipes() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse("http://10.0.2.2/recipes");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recipes = List<RecipeModel>.from(
            data["recipes"].map((x) => RecipeModel.fromJson(x)));
      } else {
        print("Error ${response.statusCode}");
        recipes = [];
      }
    } catch (e) {
      print("Error $e");
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(RecipeModel recipe) async {
    final isFavorite = favoriteRecipes.contains(recipe);

    try {
      final url = Uri.parse("http://10.0.2.2/favorites");
      final response = (isFavorite)
          ? await http.delete(url, body: json.encode({"id": recipe.id}))
          : await http.post(url, body: json.encode(recipe.toJson()));

      if (response.statusCode == 200) {
        if (isFavorite) {
          favoriteRecipes.remove(recipe);
        } else {
          favoriteRecipes.add(recipe);
        }
        notifyListeners();
      } else {
        throw Exception("Failed to update favorite recipes.");
      }
    } catch (e) {
      print("Error updating favorite status $e.");
    }
  }
}
