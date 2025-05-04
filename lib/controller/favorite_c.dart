import 'package:get/get.dart';
import '../model/product_m.dart';

class FavoriteC extends GetxController {
  // List of items
  final RxList<PItem> items =
      <PItem>[
        PItem(
          id: 1,
          image: 'images/TUV.png',
          name: "Men's Shoes: Nike IN",
          description: "Men's Shoes: Nike IN",
          price: 150000,
          Type: 1,
          favorite: true,
        ),
        PItem(
          id: 2,
          image: 'images/TUV.png',
          name: "Men's Shoes: Nike IN",
          description: "Men's Shoes: Nike IN",
          price: 150000,
          Type: 1,
          favorite: false,
        ),
      ].obs;

  List<PItem> get favoriteItems =>
      items.where((item) => item.favorite).toList();

  void toggleFavorite(int index) {
    items[index].favorite = !items[index].favorite;
    items.refresh();
  }
}
