class Product {
  int id;
  String title;
  double price;
  String image;
  int quantity;
  List<Product> cartItems = []; // Your list of cart items

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 0,
  });
 static List<Product> productList = [
      Product(
        id: 1,
        title: 'Maquereau Petit',
        image:
            'assets/images/maquereau.jpg',
        price: 2000),
    Product(
        id: 2,
        title: 'Maquereau Moyen',
        image:
            'assets/images/maquereau.jpg',
        price: 2500),
    Product(
        id: 3,
        title: 'Maquereau Gros',
        image:
            'assets/images/maquereau.jpg',
        price: 3000),
    Product(
        id: 4,
        title: 'Maquereau Géant',
        image:
            'assets/images/maquereau.jpg',
        price: 3500),
    Product(
        id: 5,
        title: 'Carpe Petit',
        image:
            'assets/images/carpe.jpg',
        price: 2500),
    Product(
        id: 6,
        title: 'Carpe Moyen',
        image:
            'assets/images/carpe.jpg',
        price: 4000),
    Product(
        id: 7,
        title: 'Carpe Géant',
        image:
            'assets/images/carpe.jpg',
        price: 6000),
    Product(
        id: 8,
        title: 'Carpe Gros',
        image:
            'assets/images/carpe.jpg',
        price: 5000),
         Product(
        id: 9,
        title: 'Carpe Collosal',
        image:
            'assets/images/carpe.jpg',
        price: 7000),
 Product(
        id: 10,
        title: 'Sole Petit',
        image:
            'assets/images/sole.jpg',
        price: 5000),
         Product(
        id: 11,
        title: 'Sole Moyen',
        image:
            'assets/images/sole.jpg',
        price: 6000),
 Product(
        id: 12,
        title: 'Sole Gros',
        image:
            'assets/images/sole.jpg',
        price: 10000),

    Product(
        id: 13,
        title: 'Sole Géant',
        image:
            'assets/images/sole.jpg',
        price: 12000),
    Product(
        id: 14,
        title: 'Sole Colossal',
        image:
            'assets/images/sole.jpg',
        price: 9000),
         Product(
        id: 15,
        title: 'Bar petit',
        image:
            'assets/images/bar.jpg',
        price: 5000),
         Product(
        id: 16,
        title: 'Bar Moyen',
        image:
            'assets/images/bar.jpg',
        price: 7000),
         Product(
        id: 17,
        title: 'Bar Gros',
        image:
            'assets/images/bar.jpg',
        price: 10000),
         Product(
        id: 18,
        title: 'Bar Géant',
        image:
            'assets/images/bar.jpg',
        price: 25000),
         Product(
        id: 19,
        title: 'Bar Colossal',
        image:
            'assets/images/bar.jpg',
        price: 9000),
         Product(
        id: 20,
        title: 'Machoiron Moyen',
        image:
            'assets/images/machoirons.jpg',
        price: 5000),
         Product(
        id: 21,
        title: 'Machoiron Gros',
        image:
            'assets/images/machoirons.jpg',
        price: 6000),
          Product(
        id: 22,
        title: 'Machoiron Géant',
        image:
            'assets/images/machoirons.jpg',
        price: 7000),
          Product(
        id: 23,
        title: 'Machoiron Colossal',
        image:
            'assets/images/machoirons.jpg',
        price: 8000),
          Product(
        id: 24,
        title: 'Gambas',
        image:
            'assets/images/gambas.jpg',
        price: 10000),
          Product(
        id: 25,
        title: 'Bossu Petit',
        image:
            'assets/images/bossu.jpg',
        price: 1500),
         Product(
        id: 26,
        title: 'Bossu Moyen',
        image:
            'assets/images/bossu.jpg',
        price: 2500),
         Product(
        id: 27,
        title: 'Bossu Gros',
        image:
            'assets/images/bossu.jpg',
        price: 1500),
         Product(
        id: 28,
        title: 'Bossu Géant',
        image:
            'assets/images/bossu.jpg',
        price: 4500),
         Product(
        id: 29,
        title: 'Bossu Colossal',
        image:
            'assets/images/bossu.jpg',
        price: 6500),
         Product(
        id: 30,
        title: 'Sillure Petit',
        image:
            'assets/images/sillure.jpg',
        price: 4000),
          Product(
        id: 31,
        title: 'Sillure Moyen',
        image:
            'assets/images/sillure.jpg',
        price: 5000),
          Product(
        id: 32,
        title: 'Sillure Gros',
        image:
            'assets/images/sillure.jpg',
        price: 7000),
  ];
// Calculate the total quantity of cart items
  static int calculateTotalQuantity(List<Product> cartItems) {
    int totalQuantity = 0;
    for (var item in cartItems) {
      totalQuantity += item.quantity;
    }
    return totalQuantity;
  }

  // Calculate the total price of cart items
  static double calculateTotalPrice(List<Product> cartItems) {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
    };
  }
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
