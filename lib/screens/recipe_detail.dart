import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/providers/recipes_provider.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key, required this.recipesData});

  final RecipeModel recipesData;

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                _controller.reverse();
              }
            },
          ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipes
        .contains(widget.recipesData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipesData.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                (isFavorite) ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            onPressed: () async {
              await Provider.of<RecipesProvider>(context, listen: false)
                  .toggleFavoriteStatus(widget.recipesData);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(widget.recipesData.imageLink),
            const SizedBox(height: 8),
            Text(widget.recipesData.name),
            const SizedBox(height: 8),
            Text("by ${widget.recipesData.author}"),
            const SizedBox(height: 8),
            const Text("Recipe steps:"),
            for (var step in widget.recipesData.recipeSteps) Text("- $step"),
          ],
        ),
      ),
    );
  }
}

// Old animation
// AnimatedSwitcher(
//  duration: const Duration(milliseconds: 300),
//  transitionBuilder: (child, animation) {
//    return ScaleTransition(scale: animation, child: child);
//  },
//  child: Icon(
//    (isFavorite) ? Icons.favorite : Icons.favorite_border,
//    color: Colors.red,
//    key: ValueKey<bool>(isFavorite),
//  ),
