import 'package:flutter/material.dart';
import 'package:flutter_real_estate/common/color_coverter.dart';
import 'package:flutter_real_estate/pages/home/pages/home_page.dart';
import 'package:flutter_real_estate/pages/search/pages/search_page.dart';
import 'package:get/get.dart';

class LandPage extends StatefulWidget {
  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/welcome.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.4, 0.7, 1.0],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.blue[900].withOpacity(.8),
              Colors.deepPurpleAccent.withOpacity(.8),
              Colors.deepPurple.withOpacity(.8),
              Colors.purple.withOpacity(.8)
            ],
          )),
        ),
        Positioned(
          top: 100,
          bottom: 20,
          left: 0,
          right:0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Real Estate",
                  style: Get.textTheme.headline3.copyWith(fontFamily: "Medium", color: Colors.white, letterSpacing: .5),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Best place to rent your next home",
                  style: Get.textTheme.bodyText1.copyWith(fontFamily: "Medium", color: Colors.white, letterSpacing: .5),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ButtonTheme(
                  minWidth: 220,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      Get.to(SearchPage(),transition: Transition.cupertino);
                    },
                    child: Text("Let's Search",
                        style: Get.textTheme.bodyText1
                            .copyWith(fontFamily: "Medium", color: Colors.white, letterSpacing: .5)),
                  ),
                ),
                ButtonTheme(
                  minWidth: 220,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      Color materialColor = Colors.blue;
                      print(materialColor);

                      final hexColor = materialColor.value.toRadixString(16);
                      print(hexColor);

                      print(HexColor(hexColor));

                      setState(() {
                        color = HexColor(hexColor);
                      });

                    },
                    color: Colors.orange[400],
                    child: Text("Add property",
                        style: Get.textTheme.bodyText1
                            .copyWith(fontFamily: "Medium", color: color, letterSpacing: .5)),
                  ),
                ),
                Spacer(),
                ButtonTheme(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  minWidth: 220,
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {
                      Get.to(HomePage(),transition: Transition.cupertino);
                    },
                    color: Colors.orange[400],
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Property for rent",
                            style: Get.textTheme.bodyText1
                                .copyWith(fontFamily: "Medium", color: Colors.white, letterSpacing: .5)),
                        SizedBox(width: 10),
                        Icon(Icons.keyboard_arrow_right, color: Colors.white,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
