import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
