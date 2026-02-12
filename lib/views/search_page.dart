import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../viewmodels/search_viewmodel.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: SearchPageContent(),
    );
  }
}

class SearchPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Rechercher Pokémon')),
      drawer: AppDrawer(),
      body: Column(
        children: [
          _buildSearchField(viewModel),
          Expanded(child: _buildBody(viewModel)),
        ],
      ),
    );
  }

  Widget _buildSearchField(SearchViewModel vm) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Nom du Pokémon...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: vm.setQuery,
      ),
    );
  }

  Widget _buildBody(SearchViewModel vm) {
    if (vm.query.isEmpty) {
      return Center(
        child: Text('Tape un nom de Pokémon ', style: TextStyle(fontSize: 16)),
      );
    }

    if (vm.loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(child: Text('Erreur : ${vm.error}'));
    }

    if (vm.results.isEmpty) {
      return Center(child: Text('Aucun résultat'));
    }

    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: vm.results.length,
      itemBuilder: (context, index) {
        final card = vm.results[index];

        return Card(
          child: Column(
            children: [
              Expanded(child: Image.network(card.imageUrl)),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  card.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
