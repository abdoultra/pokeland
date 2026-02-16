import 'package:flutter/material.dart';
import '../models/pokemon_card.dart';

class DetailPage extends StatelessWidget {
  final PokemonCard card;

  const DetailPage({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(card.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(card.imageUrl, height: 250),
            SizedBox(height: 20),
            Text(
              card.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('HP : ${card.hp ?? "Inconnu"}'),
            Text('Rareté : ${card.rarity ?? "Inconnue"}'),
          ],
        ),
      ),
    );
  }
}
