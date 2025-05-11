import 'package:app_shoe/controller/cart_c.dart';
import 'package:flutter/material.dart';
import 'package:app_shoe/model/product_m.dart';
import 'package:get/get.dart';
import 'package:app_shoe/controller/shop_c.dart';

class ProductDetails extends StatelessWidget {
  final PItem product;
  final shop_c = Get.find<ShopC>();
  final RxInt selectedSizeIndex = (0).obs;
  final RxInt selectedColorIndex = (0).obs;

  ProductDetails({required this.product});
  final cart_c = Get.put(CartC());
  @override
  Widget build(BuildContext context) {
    List<String> sizes = (product.size ?? "null").split(',');
    List<String> colors = (product.color ?? "null").split(',');

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(color: Color(0xFFE8F5E9)),
              child: Image.network(
                product.image ?? '',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name ?? 'Unnamed Product',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${product.price} K',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description ?? 'No description available',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sizes.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () => selectedSizeIndex.value = index,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        selectedSizeIndex.value == index
                                            ? Colors.green
                                            : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      selectedSizeIndex.value == index
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    sizes[index].trim(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          selectedSizeIndex.value == index
                                              ? Colors.green
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Color',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colors.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () => selectedColorIndex.value = index,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        selectedColorIndex.value == index
                                            ? Colors.green
                                            : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      selectedColorIndex.value == index
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    colors[index].trim(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          selectedColorIndex.value == index
                                              ? Colors.green
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      int index = shop_c.items.indexOf(product);
                      if (index != -1) {
                        String selectedSize =
                            sizes[selectedSizeIndex.value].trim();
                        String selectedColor =
                            colors[selectedColorIndex.value].trim();

                        // Create a copy of the product with selected options
                        final cartItem = PItem(
                          id: product.id,
                          name: product.name,
                          price: product.price,
                          description: product.description,
                          image: product.image,
                          size: selectedSize,
                          color: selectedColor,
                          quantity: 1,
                        );

                        cart_c.addItem(cartItem);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
