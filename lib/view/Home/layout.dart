import 'package:app_shoe/controller/favorite_c.dart';
import 'package:app_shoe/controller/shop_c.dart';
import 'package:app_shoe/view/Home/account.dart';
import 'package:app_shoe/view/Home/cart.dart';
import 'package:app_shoe/view/Home/favorite.dart';
import 'package:app_shoe/view/Home/home.dart';
import 'package:app_shoe/view/Home/shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final shop_c = Get.put(ShopC());
  final fav_c = Get.put(FavoriteC());
  int _currentPage = 0;
  final List<Widget> _pages = [
    Home(),
    Shop(),
    Cart(),
    Favorite(),
    Account(),
  ]; // Add your other pages here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          _currentPage == 4
              ? null
              : AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: SizedBox.shrink(),
                title: Center(child: Image.asset('images/TUV.png', width: 50)),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/home.png', width: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/shop.png', width: 24),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/cart.png', width: 24),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/like.png', width: 24),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/profile.png', width: 24),
            label: 'Account',
          ),
        ],
        currentIndex: _currentPage,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
          if (_currentPage == 1) {
            shop_c.refreshShopData();
          }
          if (_currentPage == 3) {
            fav_c.initUserId();
          }
        },
      ),
    );
  }
}
