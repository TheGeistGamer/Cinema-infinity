import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessage() {
    const message = [
      'Cargando Peliculas',
      'Comprando palomitas de maiz',
      'Cargando populares',
      'Cargando proximos estrenos',
      'Ya mero...',
      'Esto esta tardando mas de lo esperado'
    ];

    return Stream.periodic(
            const Duration(milliseconds: 1500), (step) => message[step])
        .take(message.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Espere por favor'),
        const SizedBox(height: 10),
        const CircularProgressIndicator(),
        const SizedBox(height: 10),
        StreamBuilder(
            stream: getLoadingMessage(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data.toString());
            })
      ],
    ));
  }
}
