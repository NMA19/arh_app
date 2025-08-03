import 'package:flutter/material.dart';

class LoadEaseScreen extends StatelessWidget {
  const LoadEaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LoadEase"),
        backgroundColor: const Color(0xFF586C7C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("2. LoadEase (Service de logistique intelligente)"),
              const SizedBox(height: 12),
              _sectionTitle("\u2022 Transport de marchandises :"),
              _bullet("o R\u00e9servation de v\u00e9hicules (camions, utilitaires) en fonction du volume/type d'objets."),
              _bullet("o Comparaison de prix entre prestataires (partenariats avec des transporteurs)."),
              const SizedBox(height: 12),
              _sectionTitle("\u2022 D\u00e9m\u00e9nagement :"),
              _bullet("o Forfaits cl\u00e9s en main (emballage, transport, montage de meubles)."),
              _bullet("o Suivi GPS en temps r\u00e9el."),
              const SizedBox(height: 12),
              _sectionTitle("Extensions possibles :"),
              _bullet("\u2022 Optimisation d'espace : L'IA calcule le meilleur arrangement des meubles dans le v\u00e9hicule."),
              _bullet("\u2022 Stockage temporaire : Int\u00e9gration avec des partenaires entrep\u00f4ts."),
              const SizedBox(height: 12),
              _sectionTitle("Technologies envisag\u00e9es :"),
              _bullet("\u2022 API de g\u00e9olocalisation (Google Maps, Here Technologies)."),
              _bullet("\u2022 Algorithmes de matching (pour relier demandeurs et transporteurs disponibles)."),
              const SizedBox(height: 12),
              _sectionTitle("Exemple d'usage :"),
              _text("Un client ach\u00e8te des meubles sur ArchConnect et commande un camion via LoadEase pour la livraison le jour m\u00eame."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Color(0xFF586C7C),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
