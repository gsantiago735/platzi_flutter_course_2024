import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _reciperCard(context),
          _reciperCard(context),
          _reciperCard(context),
        ],
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
          child: Text("Hola"),
        );
      },
    );
  }

  Widget _reciperCard(BuildContext context) {
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
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    "https://static.platzi.com/media/uploads/flutter_lasana_b894f1aee1.jpg",
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

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
          // key: _formKey,
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
          _buildTextField(label: "Recipe Name"),
        ],
      )),
    );
  }

  Widget _buildTextField({required String label}) {
    return TextFormField(
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
