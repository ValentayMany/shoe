import 'package:app_shoe/services/apiconstants.dart';
import 'package:app_shoe/services/apiservice.dart';
import '../model/product_m.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:app_shoe/view/Home/product_details.dart';

class ShopC extends GetxController {
  final ApiService _apiService = ApiService();
  final RxList<PItem> _items = <PItem>[].obs;
  final RxList<PItem> _cartItems = <PItem>[].obs;
  final RxList<bool> isLikedList = <bool>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString currentCategory = 'ALL'.obs;

  // Cache for products by category
  final Map<String, List<PItem>> _categoryCache = {};

  List<PItem> get items => _items;
  List<PItem> get cartItems => _cartItems;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  Future<void> _initData() async {
    await fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (isLoading.value) return; // Prevent multiple simultaneous calls

    try {
      isLoading.value = true;
      error.value = '';
      currentCategory.value = 'ALL';

      final response = await _apiService.post(
        ApiConstants.productsEndpoint,
        data: {},
      );

      if (response.success) {
        final products =
            (response.data['products'] as List)
                .map((json) => PItem.fromJson(json))
                .toList();

        _categoryCache['ALL'] = products;
        _updateItemsFromCache('ALL');
      } else {
        error.value = 'Failed to fetch products: ${response.message}';
        _showErrorMessage(error.value);
      }
    } catch (e) {
      error.value = 'Error fetching products: $e';
      _showErrorMessage(error.value);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // void fetchCategoryProducts(String categoryId) async {
  //   print('categoryId: $categoryId');
  // }

  Future<void> fetchCategoryProducts(String categoryId) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      error.value = '';
      currentCategory.value = categoryId;

      final response = await _apiService.post(
        '${ApiConstants.productsEndpoint}$categoryId',
        data: {},
      );

      if (response.success) {
        final products =
            (response.data['products'] as List)
                .map((json) => PItem.fromJson(json))
                .toList();

        _categoryCache[categoryId] = products;
        _updateItemsFromCache(categoryId);
      } else {
        error.value = 'Failed to fetch products: ${response.message}';
        _showErrorMessage(error.value);
      }
    } catch (e) {
      error.value = 'Error fetching products: $e';
      _showErrorMessage(error.value);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void _updateItemsFromCache(String categoryId) {
    final cachedProducts = _categoryCache[categoryId];
    if (cachedProducts != null) {
      _items.clear();
      _items.addAll(cachedProducts);
      isLikedList.value = _items.map((item) => item.favorite).toList();
      update();
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
    final item = _items[index];
    showModalBottomSheet(
      context: Get.context!,
      builder:
          (c) => Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  item.image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16),
                Text(
                  item.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('ລາຄາ: ${item.price.toString()} K'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _cartItems.add(item);
                    Get.back();
                    Get.snackbar(
                      'Added to Cart',
                      '${item.name} has been added to your cart.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green.withOpacity(0.8),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 45),
                  ),
                  child: Text('Add to Cart', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
    );
  }

  void openProductDetails(int index) {
    Get.to(() => ProductDetails(product: _items[index]));
  }
}
