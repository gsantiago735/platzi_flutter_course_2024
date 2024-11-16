import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recipe_book/models/recipe_model.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<RecipeModel> recipes = [];

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
}
