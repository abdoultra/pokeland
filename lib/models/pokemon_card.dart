class PokemonCard {
  final String id;
  final String name;
  final String imageUrl;
  final String? hp;
  final String? rarity;

  PokemonCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.hp,
    this.rarity,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images']['small'],
      hp: json['hp'],
      rarity: json['rarity'],
    );
  }
}
