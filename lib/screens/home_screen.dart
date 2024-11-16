import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_book/screens/recipe_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> fetchRecipes() async {
    // Android 10.0.2.2
    // IOS 127.0.0.1
    final url = Uri.parse("http://10.0.2.2/recipes");
    final response = await http.get(url);
    final data = jsonDecode(response.body);

    return data["recipes"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchRecipes(),
        builder: (context, snapshot) {
          final recipes = snapshot.data ?? [];

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return _reciperCard(context, recipes[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () => _showBottom(context),
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: const Text("Hola"),
        );
      },
    );
  }

  Widget _reciperCard(BuildContext context, dynamic recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(recipeName: recipe["name"]),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 125,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      recipe["image_link"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 26),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe["name"],
                      style: const TextStyle(
                          fontSize: 16, fontFamily: "Quicksand"),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 2,
                      width: 75,
                      color: Colors.orange,
                    ),
                    Text(
                      recipe["author"],
                      style: const TextStyle(
                          fontSize: 16, fontFamily: "Quicksand"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final recipeName = TextEditingController();
    final recipeAuthor = TextEditingController();
    final recipeUrl = TextEditingController();
    final recipeDescription = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add New Recipe",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: recipeName,
                label: "Recipe Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the name recipe.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: recipeAuthor,
                label: "Author",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the author.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: recipeUrl,
                label: "Image url",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the url.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: recipeDescription,
                label: "Description",
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the description.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: const Text(
                    "Save Recipe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      required String? Function(String?) validator,
      int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: "Quicksand",
            color: Colors.orange,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }
}
