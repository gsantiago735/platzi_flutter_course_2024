import 'package:flutter/material.dart';
import 'package:recipe_book/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hola Mundo",
      home: RecipeBook(),
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
                Tab(
                  icon: Icon(Icons.home),
                  text: "Home",
                )
              ]),
        ),
        body: const TabBarView(children: [
          HomeScreen(),
        ]),
      ),
    );
  }
}
