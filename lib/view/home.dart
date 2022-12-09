import 'package:final_project/view/profile.dart';
import 'package:flutter/material.dart';
// import 'package:final_project/uifp/view/cartitem.dart';
// import 'package:final_project/uifp/view/itemlist.dart';
// import 'package:final_project/uifp/view/favourite.dart';
// import 'package:final_project/uifp/view/profile.dart';

import 'cartitem.dart';
import 'favourite.dart';
import 'itemlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Cart1(),
    CartItem(),
    Test3(),
    Test4()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer:,
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            label: 'cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              color: Colors.black,
            ),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        fixedColor: Colors.amber,
      ),
    );
  }
}
