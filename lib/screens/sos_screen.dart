import 'package:flutter/material.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('🛠️ SoS – Artisan Assistance'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.location_on), text: 'Urgences'),
              Tab(icon: Icon(Icons.people), text: 'Recrutement'),
              Tab(icon: Icon(Icons.monetization_on), text: 'Estimation'),
              Tab(icon: Icon(Icons.school), text: 'Formations'),
              Tab(icon: Icon(Icons.reviews), text: 'Reviews'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _UrgenceTab(),
            _RecrutementTab(),
            _EstimationTab(),
            _FormationsTab(),
            _ReviewTab(),
          ],
        ),
      ),
    );
  }
}

class _UrgenceTab extends StatelessWidget {
  const _UrgenceTab();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('🔍 Artisans proches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _artisanCard('Ahmed - Plombier', 4.7, '1km', 1500),
        _artisanCard('Yacine - Électricien', 4.9, '1.5km', 1800),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.video_call, color: Colors.red),
          title: const Text('Appel vidéo en direct'),
          subtitle: const Text('Diagnostic instantané via WebRTC (mock)'),
          trailing: ElevatedButton.icon(
            icon: const Icon(Icons.call),
            label: const Text('Lancer'),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget _artisanCard(String name, double rating, String distance, int price) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.handyman),
        title: Text(name),
        subtitle: Text('Note: $rating • $distance • $price DA'),
        trailing: IconButton(
          icon: const Icon(Icons.message),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _RecrutementTab extends StatelessWidget {
  const _RecrutementTab();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('📄 Artisans disponibles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Khaled - Maçon'),
          subtitle: const Text('CV • Portfolio • 2000 DA/jour'),
          trailing: ElevatedButton(
            onPressed: () {},
            child: const Text('Voir'),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Contrats & paiements sécurisés'),
          subtitle: const Text('Via Stripe/PayPal (mock)'),
        ),
      ],
    );
  }
}

class _EstimationTab extends StatelessWidget {
  const _EstimationTab();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('📷 IA Estimation automatique', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Décrivez le problème',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Envoyer une photo'),
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            const Text('💡 Coût estimé: ~3500 DA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _FormationsTab extends StatelessWidget {
  const _FormationsTab();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('🎓 Formations disponibles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _formationCard('Certification Plomberie 2025'),
        _formationCard('Sécurité électrique – Réglementation 2025'),
      ],
    );
  }

  Widget _formationCard(String title) => Card(
  child: ListTile(
  leading: const Icon(Icons.school),
  title: Text(title),
  subtitle: const Text('En ligne • Gratuite • Certificat délivré'),
  trailing: ElevatedButton(
  onPressed: () {},
    child: const Text("S'inscrire"),

  ),
  ),
  );
}

class _ReviewTab extends StatelessWidget {
  const _ReviewTab();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('⭐ Avis sur les artisans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _reviewTile('Samir - Plombier', 5.0, 'Très rapide et pro !'),
        _reviewTile('Lina - Électricienne', 4.5, 'Bon travail, ponctuelle.'),
      ],
    );
  }

  Widget _reviewTile(String name, double rating, String comment) => ListTile(
    leading: const Icon(Icons.person_pin),
    title: Text(name),
    subtitle: Text('$rating ★ - "$comment"'),
    trailing: const Icon(Icons.thumb_up_alt_outlined, color: Colors.green),
  );
}
