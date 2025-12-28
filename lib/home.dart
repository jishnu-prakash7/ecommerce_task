import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/cart/presentation/pages/cart_screen.dart';
import 'package:ecommerce/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:ecommerce/features/products_list/presentation/pages/products_list_screen.dart';
import 'package:ecommerce/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:ecommerce/features/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int initialPageIndex;
  const HomeScreen({super.key, this.initialPageIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _pages = [];

  void _onItemTapped(int index) {
    if (index == 0 && _selectedIndex !=0) {
      sl<ProductsListBloc>().add(FetchProductsListEvent());
    } else if (index == 1) {
      sl<CartBloc>().add(GetCartListEvent());
    } else if (index == 2) {
      sl<WishlistBloc>().add(GetWishlistEvent());
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    sl<ProductsListBloc>().add(FetchProductsListEvent());
    _selectedIndex = widget.initialPageIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [ProductListScreen(), CartScreen(), WishlistScreen()];
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: sizeHelper.getWidgetHeight(70),
        decoration: BoxDecoration(color: Colors.white),
        child: BottomNavigationBar(
          enableFeedback: false,
          selectedLabelStyle: TextStyle(
            fontSize: sizeHelper.getTextSize(13),
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: sizeHelper.getTextSize(13),
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: sizeHelper.getWidgetHeight(4)),
                child: Icon(
                  Icons.dashboard,
                  size: sizeHelper.getTextSize(25),
                  color: _selectedIndex == 0 ? Colors.teal : Colors.grey,
                ),
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: sizeHelper.getWidgetHeight(4)),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  size: sizeHelper.getTextSize(25),
                  color: _selectedIndex == 1 ? Colors.teal : Colors.grey,
                ),
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: sizeHelper.getWidgetHeight(4)),
                child: Icon(
                  Icons.shopping_bag_rounded,
                  size: sizeHelper.getTextSize(25),
                  color: _selectedIndex == 2 ? Colors.teal : Colors.grey,
                ),
              ),
              label: 'Wishlist',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 20,
          onTap: _onItemTapped,
          unselectedItemColor: Colors.grey,
          selectedFontSize: sizeHelper.getTextSize(11),
          unselectedFontSize: sizeHelper.getTextSize(11),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
      ),
    );
  }
}
