class Product {
  final int id;
  final String title;
  final String description;
  final double rating;
  final double price;
  final int stock;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.price,
    required this.stock,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      price: json['price'].toDouble(),
      stock: json['stock'],
      thumbnail: json['thumbnail'],
    );
  }
}
