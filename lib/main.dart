import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/home/land_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

