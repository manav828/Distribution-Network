import 'package:ami_milk/Bottom_Navigation_Display/search.dart';
import 'package:flutter/material.dart';

import '../Bottom_Navigation_Display/cart.dart';
import '../Bottom_Navigation_Display/profile.dart';
import 'all_items_home/homePage.dart';

class mainHomePageDesign extends StatefulWidget {
  @override
  State<mainHomePageDesign> createState() => _State();
}

class _State extends State<mainHomePageDesign> {
  int _currentIndex = 0;
  var _pageData = [homePage(), Search(), Cart(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _pageData[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.white,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // print(_currentIndex);
          });
        },
      ),
    );
  }
}
