import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/pokemon_card.dart';
import '../services/pokemon_service.dart';

class SearchViewModel extends ChangeNotifier {
  final PokemonService _service = PokemonService();

  List<PokemonCard> _results = [];
  bool _loading = false;
  String? _error;
  String _query = '';

  Timer? _debounce;

  List<PokemonCard> get results => _results;
  bool get loading => _loading;
  String? get error => _error;
  String get query => _query;

  void setQuery(String value) {
    _query = value;

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(Duration(milliseconds: 500), () {
      search();
    });

    notifyListeners();
  }

  Future<void> search() async {
    if (_query.isEmpty) {
      _results = [];
      _error = null;
      notifyListeners();
      return;
    }

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _results = await _service.fetchCards(query: _query);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
