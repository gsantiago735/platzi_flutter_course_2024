import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesProvider =
        Provider.of<RecipesProvider>(context, listen: false);
    recipesProvider.fetchRecipes();

    return Scaffold(
      body: Consumer<RecipesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.recipes.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noRecipes));
          } else {
            return ListView.builder(
              itemCount: provider.recipes.length,
              itemBuilder: (context, index) {
                return _reciperCard(context, provider.recipes[index]);
              },
            );
          }
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

  Widget _reciperCard(BuildContext context, RecipeModel recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(recipesData: recipe),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 125,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      recipe.imageLink,
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
                      recipe.name,
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
                      "By ${recipe.author}",
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
