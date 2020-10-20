import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_real_estate/common/color_coverter.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/pages/profile/components/my_client.dart';
import 'package:flutter_real_estate/pages/profile/components/my_dalali.dart';
import 'package:flutter_real_estate/pages/profile/components/manage_account.dart';
import 'package:flutter_real_estate/pages/profile/components/profile_drawer.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profileScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _profileScaffoldKey,
        drawer: Drawer(
          child: ProfileDrawer(),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                height: constraints.maxHeight * .35,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: HexColor('8896B0'),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: constraints.maxHeight * .13, left: 20, right: 20, bottom: 40),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.withOpacity(.4),
                                  spreadRadius: -3,
                                  blurRadius: 20,
                                  offset: Offset(0, 5))
                            ]),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  child: InkWell(
                                    onTap:(){},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: AssetImage("assets/images/default.jpg"),
                                        height: 110,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: GetX<UserController>(
                                      //init: UserController(),
                                      builder: (userController) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${userController.userData.value.name}",
                                              style: Get.textTheme.headline6.copyWith(fontFamily: "Medium"),
                                            ),
                                            Text(
                                              "${userController.userData.value.email}",
                                              style: TextStyle(color: Colors.grey, fontSize: 13),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.blueGrey.withOpacity(.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Property",
                                                        style: TextStyle(
                                                            color: Colors.blueGrey, fontFamily: "medium", fontSize: 14),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "12",
                                                        style: Get.textTheme.headline6.copyWith(fontFamily: "Medium"),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Available",
                                                        style: TextStyle(
                                                            color: Colors.blueGrey, fontFamily: "medium", fontSize: 14),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "4",
                                                        style: Get.textTheme.headline6.copyWith(fontFamily: "Medium"),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Dalali",
                                                        style: TextStyle(
                                                            color: Colors.blueGrey, fontFamily: "medium", fontSize: 14),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "2",
                                                        style: Get.textTheme.headline6.copyWith(fontFamily: "Medium"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: ButtonTheme(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    child: OutlineButton(
                                      onPressed: () {
                                        _profileScaffoldKey.currentState.openDrawer();
                                      },
                                      child: Text(
                                        "Manage",
                                        style: TextStyle(fontFamily: "medium"),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: ButtonTheme(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    child: FlatButton(
                                      color: Colors.green[700],
                                      onPressed: () {},
                                      child: Text(
                                        "Upgrade now",
                                        style: TextStyle(fontFamily: "medium", color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      MyProperty(),
                      MyClient(),
                      MyDalali(),
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[600], boxShadow: []),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: AssetImage("assets/images/be_pro.jpg"),
                                      height: 105,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Become Pro",
                                        style:
                                            Get.textTheme.headline6.copyWith(fontFamily: "Medium", color: Colors.white),
                                      ),
                                      Text(
                                        "Get more done with pro",
                                        style: TextStyle(color: Colors.grey[400], fontFamily: "medium", fontSize: 15),
                                      ),
                                      SizedBox(height: 25),
                                      ButtonTheme(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        child: FlatButton(
                                          color: Colors.green[700],
                                          onPressed: () {},
                                          child: Text(
                                            "Upgrade now",
                                            style: TextStyle(fontFamily: "medium", color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
