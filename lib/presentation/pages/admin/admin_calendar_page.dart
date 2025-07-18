import 'package:flutter/material.dart';

class AdminCalendarPage extends StatelessWidget {
  const AdminCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Actividades'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('Contenido del calendario administrativo'),
      ),
    );
  }
}
