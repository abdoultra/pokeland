import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../viewmodels/explore_viewmodel.dart';
import 'detail_page.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExploreViewModel()..loadCards(),
      child: ExplorePageContent(),
    );
  }
}

class ExplorePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ExploreViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Explorer les Pokémon')),
      drawer: AppDrawer(),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(ExploreViewModel vm) {
    if (vm.loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(child: Text('Erreur : ${vm.error}'));
    }

    if (vm.cards.isEmpty) {
      return Center(child: Text('Aucune carte trouvée'));
    }

    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: vm.cards.length,
      itemBuilder: (context, index) {
        final card = vm.cards[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(card: card),
              ),
            );
          },
          child: Card(
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
          ),
        );
      },
    );
  }
}
