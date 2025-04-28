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
}
