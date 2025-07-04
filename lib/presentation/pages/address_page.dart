import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../widgets/custom_button.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado con título y botón de cerrar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Center(
                    child: Text(
                      'DIRECCIONES',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 28),
                      onPressed: () => context.go(AppRoutes.profile),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Tarjeta con dirección guardada
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Datos de dirección
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Kevin Rodriguez Lima',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Calle Leticia R8 En Jose Santos Atahualpa'),
                            SizedBox(height: 4),
                            Text(
                              '040104 CERRO COLORADO',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('AREQUIPA'),
                            Text('953992171'),
                          ],
                        ),
                      ),
                    ),
                    // Botón editar
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.grey),
                      onPressed: () {
                        // Acción futura para editar dirección
                      },
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Botón "Agregar nueva dirección" usando CustomButton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: CustomButton(
                text: 'AGREGAR NUEVA DIRECCIÓN',
                icon: Icons.add,
                onPressed: () {
                  // Acción futura para agregar dirección
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
