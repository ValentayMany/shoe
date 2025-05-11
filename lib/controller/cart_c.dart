import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../model/product_m.dart';

class CartC extends GetxController {
  final RxList<PItem> _items = <PItem>[].obs;
  final RxDouble _total = 0.0.obs;

  List<PItem> get items => _items;
  double get total => _total.value;

  void addItem(PItem item) {
    // Check if item already exists with same id, size and color
    final existingItemIndex = _items.indexWhere(
      (existing) =>
          existing.id == item.id &&
          existing.size == item.size &&
          existing.color == item.color,
    );

    if (existingItemIndex != -1) {
      // If item exists, increment quantity
      _items[existingItemIndex].quantity =
          (_items[existingItemIndex].quantity ?? 1) + 1;
      _items.refresh();
      Get.snackbar(
        'Cart Updated',
        'Item quantity has been increased\nSize: ${item.size}\nColor: ${item.color}',
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      );
    } else {
      // Add new item
      item.quantity ??= 1;
      item.price ??= 0.0;
      _items.add(item);
      Get.snackbar(
        'Added to Cart',
        'Product ${item.name} has been added to your cart\nSize: ${item.size}\nColor: ${item.color}',
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      );
    }
    _calculateTotal();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _calculateTotal();
  }

  void updateQuantity(int index, int change) {
    if (index >= 0 && index < _items.length) {
      final item = _items[index];
      item.quantity ??= 1;

      if ((item.quantity! + change) > 0) {
        item.quantity = item.quantity! + change;
        _items.refresh();
        _calculateTotal();
      }
    }
  }

  void _calculateTotal() {
    _total.value = _items.fold(
      0.0,
      (sum, item) => sum + ((item.price ?? 0.0) * (item.quantity ?? 1)),
    );
  }

  Future<void> Checkout() async {
    try {
      EasyLoading.show(status: 'Processing checkout...');
      await Future.delayed(Duration(seconds: 2));
      _items.clear();
      _calculateTotal();
      Get.snackbar(
        'Success',
        'Your order has been placed successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process checkout',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
