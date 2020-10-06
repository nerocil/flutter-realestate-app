
import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/profile/pages/manage_profile.dart';
import 'package:get/get.dart';

import 'action_list.dart';

class ProfileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.blueGrey[600], boxShadow: []),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: AssetImage("assets/images/300_14.jpg"),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Become Pro",
                          style: Get.textTheme.headline6.copyWith(fontFamily: "Medium", color: Colors.white),
                        ),
                        Text(
                          "Get more done with pro",
                          style: TextStyle(color: Colors.grey[400], fontFamily: "medium", fontSize: 15),
                        ),
                        SizedBox(height: 20),
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
        SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ActionList(
                  iconData: Icons.settings,
                  title: "Account",
                  subTitle: "Edit and manage your account details",
                  proFeature: false,
                  onTap: () {Get.to(ManageAccount());},
                ),
                Divider(),
                ActionList(
                  iconData: Icons.home,
                  title: "Properties",
                  subTitle: "Add, Edit and manage your properties",
                  proFeature: false,
                  onTap: () {},
                ),
                Divider(),
                ActionList(
                  iconData: Icons.supervisor_account,
                  title: "Client",
                  subTitle: "Add, Edit and manage your clients",
                  proFeature: true,
                  onTap: () {},
                ),
                Divider(),
                ActionList(
                  iconData: Icons.supervisor_account,
                  title: "Dalali",
                  subTitle: "Add, Edit and manage your dalali",
                  proFeature: true,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
