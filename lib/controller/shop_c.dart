import '../model/product_m.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ShopC extends GetxController {
  final List<PItem> _items = [
    PItem(
      id: 1,
      image: 'images/TUV.png',
      name: "Men's Shoes: Nike IN",
      description: "Men's Shoes: Nike IN",
      price: 150000,
      favorite: false,
    ),
    PItem(
      id: 2,
      image: 'images/TUV.png',
      name: "Men's Shoes: Nike IN",
      description: "Men's Shoes: Nike IN",
      price: 150000,
      favorite: true,
    ),
  ];
  List<PItem> get items => _items;
  //-----------------------
  RxList<bool> isLikedList = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    isLikedList.value = _items.map((item) => item.favorite).toList();
  }

  void toggleLike(int index) {
    _items[index].favorite = !_items[index].favorite;
    isLikedList[index] = _items[index].favorite;
    update();
  }

  Widget buildLikeButton(int index) {
    return IconButton(
      icon: Icon(
        isLikedList[index] ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () => toggleLike(index),
    );
  }

  void addToCart(int index) {
    Get.snackbar(
      'Added to Cart',
      '${_items[index].name} (Index: $index)  has been added to your cart.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void openProductDetails(int index) {
    print('Item clicked: ${index}');
  }
}
