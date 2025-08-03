import 'package:flutter/material.dart';

class MagicPlanScreen extends StatelessWidget {
  const MagicPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magic Plan'),
        backgroundColor: const Color(0xFF586C7C),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("🧠 Magic Plan (Outil de génération/modification de plans via IA)"),
                  const SizedBox(height: 12),
                  _text(
                    "Générez et modifiez automatiquement vos plans en 2D/3D grâce à l'intelligence artificielle. "
                        "Téléversez un plan ou saisissez vos critères, et laissez l'IA proposer un agencement optimal.",
                  ),
                  const SizedBox(height: 20),

                  _sectionTitle("🔧 Fonctionnalités principales"),
                  const SizedBox(height: 8),
                  _bullet("• Génération automatique de plans :"),
                  _bullet("   o Entrée des données : surface, pièces, style architectural, contraintes"),
                  _bullet("   o Sortie : plusieurs plans optimisés avec suggestions d’aménagement"),
                  _bullet("   o Prise en compte des normes (accessibilité, isolation...)"),
                  const SizedBox(height: 12),
                  _bullet("• Modification via photo :"),
                  _bullet("   o Téléversement d’un plan scanné ou dessiné"),
                  _bullet("   o Vectorisation automatique et édition (ajout cloisons, échelle, etc.)"),
                  _bullet("   o Reconnaissance des éléments (portes, fenêtres) via vision par ordinateur"),

                  const SizedBox(height: 20),
                  _sectionTitle("🛠 Technologies envisagées"),
                  _bullet("• GANs (réseaux antagonistes génératifs) pour proposer des plans"),
                  _bullet("• CLIP (OpenAI) pour interprétation textuelle"),
                  _bullet("• OCR pour extraire les cotes d’un plan scanné"),
                  _bullet("• Vision par ordinateur pour reconnaissance d’éléments"),
                  _bullet("• Three.js ou Unity pour la visualisation 2D/3D"),

                  const SizedBox(height: 20),
                  _sectionTitle("📱 Exemple d’usage"),
                  _text(
                    "Un propriétaire prend en photo son studio. L’IA détecte l’espace disponible, "
                        "suggère l’ajout d’une cloison pour créer une chambre séparée, et affiche le plan en 2D/3D.",
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Button Section at Bottom
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              16,
              12,
              16,
              12 + MediaQuery.of(context).viewPadding.bottom,
            ),
            color: Colors.white,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Fonctionnalité IA bientôt disponible")),
                );
              },
              icon: const Icon(Icons.auto_fix_high),
              label: const Text("Tester la génération IA"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8BA7BE),
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color(0xFF586C7C),
      ),
    );
  }

  Widget _text(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, color: Colors.black87),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
