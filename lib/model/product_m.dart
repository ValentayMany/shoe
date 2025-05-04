class PItem {
  final double id;
  final String image;
  final String name;
  final String description;
  final double price;
  final double Type;
  bool favorite;
  int quantity;

  PItem({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.Type,
    this.favorite = false,
    this.quantity = 1,
  });
  factory PItem.fromJson(Map<String, dynamic> json) {
    return PItem(
      id: (json['Product_ID'] as num).toDouble(),
      image: json['Image'] ?? '',
      name: json['Name'] ?? '',
      description: json['Description'] ?? '',
      price: double.tryParse(json['Price'].toString()) ?? 0.0,
      quantity: json['Quantity'] ?? 1,
      Type: json['productType_ID'] ?? 1,
      favorite: false,
    );
  }
}
