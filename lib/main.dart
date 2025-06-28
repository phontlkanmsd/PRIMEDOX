import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MiPerfilWeb());
}

class MiPerfilWeb extends StatelessWidget {
  const MiPerfilWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Perfil Web',
      debugShowCheckedModeBanner: false,
      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key});

  void abrirWhatsApp(String numero, String mensaje) async {
    final mensajeCodificado = Uri.encodeComponent(mensaje);
    final url = Uri.parse('https://wa.me/$numero?text=$mensajeCodificado');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir WhatsApp';
    }
  }

  Widget perfilItem(String label, String numero, String imagenPath) {
    const mensaje = "Hola, quiero adquirir el bot de doxeo de 15 soles💻.";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(imagenPath),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => abrirWhatsApp(numero, mensaje),
          icon: const Icon(Icons.chat),
          label: const Text("WhatsApp"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Columna izquierda (imagen grande)
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: Text(
                      "PRIME DOX",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'assets/imagen_grande.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),

          // Columna derecha con imagen de fondo
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondo_perfiles.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    perfilItem("DUEÑO", "51950321131", 'assets/DUENO.jpg'),
                    const SizedBox(height: 30),
                    perfilItem("JOSE", "51913447999", 'assets/jose.jpg'),
                    const SizedBox(height: 30),
                    perfilItem("ANÓNIMO DOX", "51933333333", 'assets/anonimo.jpg'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
