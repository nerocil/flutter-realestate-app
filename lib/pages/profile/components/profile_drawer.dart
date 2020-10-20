
import 'package:flutter/material.dart';
import 'package:flutter_real_estate/common/appHelper.dart';
import 'package:flutter_real_estate/controllers/navigation_bottom_controller.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/pages/auth/pages/login_page.dart';
import 'package:flutter_real_estate/pages/profile/pages/manage_profile.dart';
import 'package:flutter_real_estate/servieces/http_service.dart';
import 'package:get/get.dart';

import 'action_list.dart';

class ProfileDrawer extends StatelessWidget {

  final UserController _userController = Get.find<UserController>();

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
                                onPressed: () async{

                                  final response = await HttpService().userLogout(url: "/user/logout", token: _userController.userToken.value);
                                  if(response.statusCode == 200){
                                    print(response.data);
                                    _userController.updateUserToken(token: null);
                                    AppHelper.removeLocalData();
                                    Get.find<NavigationBottomController>().updateIndex(index: 0);
                                    Navigator.of(context).pop();
                                    Get.to(LoginPage());
                                  }

                                },
                                child: Text(
                                  "Logout",
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
