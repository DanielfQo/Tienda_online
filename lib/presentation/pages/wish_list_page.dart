import 'package:flutter/material.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de deseos"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Aquí se mostrarán los productos que has añadido a tu lista de deseos.",
        ),
      ),
    );
  }
}