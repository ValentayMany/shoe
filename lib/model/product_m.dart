class PItem {
  final double id;
  final String image;
  final String name;
  final String description;
  final double price;
  bool favorite;
  int quantity;

  PItem({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    this.favorite = false,
    this.quantity = 1,
  });
  factory PItem.fromJson(Map<String, dynamic> json) {
    return PItem(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      favorite: json['favorite'] ?? false,
    );
  }
}
