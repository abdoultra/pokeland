import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_card.dart';

class PokemonService {
  static const String _baseUrl = 'https://api.pokemontcg.io/v2/cards';

  Future<List<PokemonCard>> fetchCards({String query = ''}) async {
    final Uri url;

    if (query.isEmpty) {
      url = Uri.parse('$_baseUrl?pageSize=20');
    } else {
      final encodedQuery = Uri.encodeComponent(query);
      url = Uri.parse('$_baseUrl?q=name:$encodedQuery&pageSize=20');
    }

    try {
      final response = await http
          .get(url)
          .timeout(Duration(seconds: 8));

      if (response.statusCode != 200) {
        throw Exception('Serveur indisponible');
      }

      final data = json.decode(response.body);
      final List<dynamic> cardsJson = data['data'];

      return cardsJson
          .map((json) => PokemonCard.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Problème réseau / API');
    }
  }
}