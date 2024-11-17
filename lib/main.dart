import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/screens/home_screen.dart';
import 'package:recipe_book/screens/favorites_screen.dart';
import 'package:recipe_book/providers/recipes_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipesProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hola Mundo",
        home: RecipeBook(),
      ),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          title: const Text(
            "Recipe Book",
            style: TextStyle(color: Colors.white),
          ),
          bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.home), text: "Home"),
                Tab(icon: Icon(Icons.home), text: "Favorites"),
              ]),
        ),
        body: const TabBarView(children: [
          HomeScreen(),
          FavoritesScreen(),
        ]),
      ),
    );
  }
}
