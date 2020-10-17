import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_real_estate/pages/auth/pages/register_page.dart';
import 'package:flutter_real_estate/pages/home/pages/home_tab_page.dart';
import 'package:flutter_real_estate/pages/profile/pages/profile_page.dart';

import 'package:flutter_real_estate/pages/search/pages/search_page.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomeTabPage(),
          SearchPage(),
          Container( child: Center(child: Text("Loved"),), ),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.green[700],
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          onTap: (index) {
            if(index == 3){
              Get.to(RegisterPage());
              return;
            }
            _pageController.jumpToPage(index);
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text("Home"),
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                title: Text("Explore"),
                activeIcon: Icon(Icons.search)),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                title: Text("Saved"),
                activeIcon: Icon(Icons.favorite)),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text("Profile"),
                activeIcon: Icon(Icons.person)),
          ]),
    );
  }
}
