import 'package:get/get.dart';
import '../model/product_m.dart';

class CartC extends GetxController {
  final RxList<PItem> _items =
      <PItem>[
        PItem(
          id: 1,
          image: 'images/TUV.png',
          name: "Men's Shoes: Nike IN",
          description: "Men's Shoes: Nike IN",
          price: 150000,
          favorite: false,
        ),
      ].obs; // Changed to RxList

  List<PItem> get items => _items;

  void updateQuantity(int index, int change) {
    _items[index].quantity = (_items[index].quantity + change).clamp(1, 99);
    _items.refresh();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _items.refresh();
  }

  double get total =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void Checkout() {
    Get.snackbar(
      'Checkout',
      'Total: ${total.toStringAsFixed(0)} K',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }
}
