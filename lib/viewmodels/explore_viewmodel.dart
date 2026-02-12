import 'package:flutter/foundation.dart';
import '../models/pokemon_card.dart';
import '../services/pokemon_service.dart';

class ExploreViewModel extends ChangeNotifier {
  final PokemonService _service = PokemonService();

  List<PokemonCard> _cards = [];
  bool _loading = false;
  String? _error;

  List<PokemonCard> get cards => _cards;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadCards() async {
    if (_loading) return;

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _cards = await _service.fetchCards();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
