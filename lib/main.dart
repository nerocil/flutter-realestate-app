import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_real_estate/controllers/navigation_bottom_controller.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/pages/home/land_page.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  Get.put(NavigationBottomController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Real Estate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "regular",
        tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.black,
          labelStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Medium",
            fontSize: 18,
          ),
          unselectedLabelColor: Colors.grey,
        ),
        indicatorColor: Colors.green[700],
        splashColor: Colors.grey,
        appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: Colors.white,
            //textTheme: TextTheme(headline6:TextStyle(color: Colors.black) ),
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandPage(),
    );
  }
}
