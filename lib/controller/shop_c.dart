import 'package:app_shoe/services/apiconstants.dart';
import 'package:app_shoe/services/apiservice.dart';

import '../model/product_m.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ShopC extends GetxController {
  final ApiService _apiService = ApiService();
  Future<void> fetchProducts() async {
    try {
      final response = await _apiService.post(
        ApiConstants.productsEndpoint,
        data: {},
      );
      if (response.success && response.data['products'] is List) {
        _items.clear();
        _items.addAll(
          (response.data['products'] as List)
              .map((json) => PItem.fromJson(json))
              .toList(),
        );

        isLikedList.value = _items.map((item) => item.favorite).toList();
        update();
      } else {
        _showErrorMessage('Failed to fetch products: ${response.message}');
      }
    } catch (e) {
      _showErrorMessage('Error fetching products: $e');
    }
  }

  void _showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  final RxList<PItem> _items = <PItem>[].obs;
  List<PItem> get items => _items;
  //-----------------------
  RxList<bool> isLikedList = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
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

  //in cart
  // final productId = _items[index].id;
  // Get.snackbar(
  //   'Added to Cart',
  //   '${productId} (Index: $productId)  has been added to your cart.',
  //   snackPosition: SnackPosition.BOTTOM,
  //   duration: Duration(seconds: 2),
  // );
  void addToCart(int index) {
    showModalBottomSheet(
      context: Get.context!,
      builder:
          (c) => Container(
            width: MediaQuery.of(c).size.width * 0.9,
            child: Column(
              children: [
                Text('Product ID: ${_items[index].id}'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(c);
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ),
    );
  }

  void openProductDetails(int index) {
    final productId = _items[index].id;
    Get.snackbar(
      'Product Details',
      'Product ID: $productId',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }
}
