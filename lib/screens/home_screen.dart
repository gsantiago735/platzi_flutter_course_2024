import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ReciperCard(context),
          _ReciperCard(context),
          _ReciperCard(context),
        ],
      ),
    );
  }

  Widget _ReciperCard(BuildContext context) {
    return Padding(
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.orange,
                ),
                //child: ClipRRect(
                //  borderRadius: const BorderRadius.all(Radius.circular(10)),
                //  child: Container(),
                //),
              ),
              const SizedBox(width: 26),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Comida",
                    style: TextStyle(fontSize: 16, fontFamily: "Quicksand"),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 2,
                    width: 75,
                    color: Colors.orange,
                  ),
                  const Text(
                    "Autor Nombre",
                    style: TextStyle(fontSize: 16, fontFamily: "Quicksand"),
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
