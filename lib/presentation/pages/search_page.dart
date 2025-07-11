import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Buscar productos",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Aquí puedes agregar la lógica para mostrar los resultados de búsqueda
            // Por ahora, solo mostramos un mensaje
            ElevatedButton(
              onPressed: () {
                // Lógica de búsqueda aquí
              },
              child: const Text("Buscar"),
            ),
          ],
        ),
      ),
    );
  }
}