import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_card.dart';

class PokemonService {
  static const String _baseUrl = 'https://api.pokemontcg.io/v2/cards';

  Future<List<PokemonCard>> fetchCards({String query = ''}) async {
    final url = query.isEmpty
        ? Uri.parse('$_baseUrl?pageSize=20')
        : Uri.parse('$_baseUrl?q=name:$query&pageSize=20');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<dynamic> cardsJson = data['data'];

      return cardsJson.map((json) => PokemonCard.fromJson(json)).toList();
    } else {
      throw Exception('Erreur API Pokémon');
    }
  }
}
