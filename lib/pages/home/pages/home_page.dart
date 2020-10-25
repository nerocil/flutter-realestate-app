import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_real_estate/controllers/navigation_bottom_controller.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/pages/auth/pages/login_page.dart';
import 'package:flutter_real_estate/pages/auth/pages/reset_password.dart';
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
  //final NavigationBottomController _navigationBottomController = Get.find<NavigationBottomController>();
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return GetX<NavigationBottomController>(
      builder: (controller) {
        return Scaffold(
              backgroundColor: Colors.white,
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.pageController.value,
                children: [
                  HomeTabPage(),
                  SearchPage(),
                  Container( child: Center(child: Text("Loved"),), ),
                  ProfilePage()
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.blue,
                  showUnselectedLabels: true,
                  currentIndex: controller.currentIndex.value,
                  onTap: (index) {
                    final userController = Get.find<UserController>();

                    if(index == 3){
                      // if(userController.userToken.value != null && userController.userData.value.emailVerifiedAt == null){
                      //   Get.to(VerifyEmail());
                      //   return;
                      // }
                      if(userController.userToken.value == null){

                        Get.to(LoginPage());
                        return;
                      }
                    }



                    controller.updateIndex(index: index);
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
    );
  }
}
