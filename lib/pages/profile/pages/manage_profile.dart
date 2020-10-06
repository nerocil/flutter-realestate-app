import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/profile/components/action_list.dart';
import 'package:get/get.dart';

class ManageAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Account",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20.0, right: 20,top: 10, bottom: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green[700],
                    ),
                    child: Icon(
                      Icons.build,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Account settings",
                            style: Get.textTheme.headline6,
                          ),
                        ],
                      ),
                      Text(
                        "Change your profile pic and edit some personal information",
                        style: Get.textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[100]),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: AssetImage("assets/images/300_14.jpg"),
                                height: 45,
                                width: 45,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(height: 3),
                                Text(
                                  "Joseph Thomson",
                                  style: Get.textTheme.headline6.copyWith(fontFamily: "Medium", color: Colors.black),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Properties owner, dalali",
                                  style: TextStyle(color: Colors.blueGrey[400], fontFamily: "medium", fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              Center(
                                  child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey,
                              )),
                            ],
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: "joseph@gmail.com",
                    decoration: InputDecoration(
                      hintText: "Email",
                      labelText: "Email",
                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                  ),
                  Divider(endIndent: 15),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: "255 714 236 368",
                    decoration: InputDecoration(
                      hintText: "Phone",
                      labelText: "Phone",
                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                  ),
                  Divider(endIndent: 15),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: "255 714 236 368",
                    decoration: InputDecoration(
                      hintText: "Phone",
                      labelText: "Phone",
                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                  ),
                  Divider(endIndent: 15),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: "Joseph Thomson",
                    decoration: InputDecoration(
                      hintText: "Full name",
                      labelText: "Full name",
                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left:20.0, right: 20,top: 30, bottom: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green[700],
                    ),
                    child: Icon(
                      Icons.live_help,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Help and Feedback",
                            style: Get.textTheme.headline6,
                          ),
                        ],
                      ),
                      Text(
                        "Reach us with your feedback and questions",
                        style: Get.textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[100]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "FAQ and Tutorials",
                        style: Get.textTheme.headline6.copyWith(color: Colors.black),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Contact us",
                        style: Get.textTheme.headline6.copyWith(color: Colors.black),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left:20.0, right: 20,top: 30, bottom: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green[700],
                    ),
                    child: Icon(
                      Icons.build,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Advance settings",
                            style: Get.textTheme.headline6,
                          ),
                        ],
                      ),
                      Text(
                        "Action may leading of loosing of your data",
                        style: Get.textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[100]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Deactivate account",
                        style: Get.textTheme.headline6.copyWith(color: Colors.black),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delete account",
                        style: Get.textTheme.headline6.copyWith(color: Colors.red),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
