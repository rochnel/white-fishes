class Complement {
  final String name;
  double price;
  final String image;

  Complement({
    required this.name,
    required this.image,
    this.price = 500.0, // Prix initial à 500 Fcfa
  });
}
