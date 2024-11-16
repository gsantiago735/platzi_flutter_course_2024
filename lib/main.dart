import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: const Text(
          "Recipe Book",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
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
                  child: Container(),
                ),
              ),
              const SizedBox(width: 26),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Comida"),
                  const Text("Autor Nombre"),
                  Container(
                    height: 2,
                    width: 75,
                    color: Colors.orange,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
