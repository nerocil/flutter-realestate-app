import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_real_estate/common/appHelper.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:flutter_real_estate/services/http_service.dart';
import 'package:get/get.dart';

class ManageAccount extends StatefulWidget {
  @override
  _ManageAccountState createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  final _userFormKey = GlobalKey<FormState>();

  bool _userFormAutoValidate = false;
  bool _isLoading = false;

  _updateUserInfo({@required User user}) async{
    setState(() {
      _userFormAutoValidate = true;
      _isLoading = true;
    });
    if(_userFormKey.currentState.validate()){
      _userFormKey.currentState.save();

      final userController = Get.find<UserController>();

      final response = await HttpService().updateUserData(url: "/user/update/${user.id}", token: userController.userToken.value, user: user);

      print(response.statusCode);

      if(response.statusCode == 200){
        final userResponse = UserResponse.fromJson(response.data);

        if(userResponse.error){
          _resetState();
          Get.snackbar("Oops!", userResponse.message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.pink[100]);
          return;
        }

        AppHelper.setUser(user: userResponse.user);
        userController.updateUser(user: userResponse.user);
        _resetState();
        Get.snackbar("Success", userResponse.message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green[100]);

        return;

      }
      Get.snackbar("Oops!", "something went wrong", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.pink[100]);
    }

    _resetState();
  }

  _resetState(){
    setState(() {
      _userFormAutoValidate = false;
      _isLoading = false;
    });
  }

  var inputDecoration = InputDecoration(
    suffixIcon: Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    alignLabelWithHint: true,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 1),
    ),
  );

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
            GetX<UserController>(
              //init: UserController(),
              builder: (userController) {
                final user = userController.userData.value;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[100]),
                  child: Form(
                    key: _userFormKey,
                    autovalidate: _userFormAutoValidate,
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
                                        user.name ?? "",
                                        style: Get.textTheme.headline6.copyWith(fontFamily: "Medium", color: Colors.black),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        user.email,
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
                          autofocus: false,
                          initialValue: user.firstName??"",
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"))
                          ],
                          validator: (value) {
                            return value.trim().length < 3 ? 'Name at-least three characters' : null;
                          },
                          onSaved: (value){ print("values is $value"); user.firstName = value; },
                          decoration:
                          inputDecoration.copyWith(hintText: 'Enter your first name', labelText: 'First name'),
                        ),
                        Divider(endIndent: 15),
                        SizedBox(height: 10),
                        TextFormField(
                          autofocus: false,
                          initialValue: user.lastName??"",
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"))
                          ],
                          validator: (value) {
                            return value.trim().length < 3 ? 'Name at-least three characters' : null;
                          },
                          onSaved: (value){ user.lastName = value; },
                          decoration:
                          inputDecoration.copyWith(hintText: 'Enter your last name', labelText: 'Last name'),
                        ),
                        Divider(endIndent: 15),
                        SizedBox(height: 10),
                        TextFormField(
                          autofocus: false,
                          initialValue: user.businessEmail ?? user.email ?? "",
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          ],
                          validator: (value) {
                            return !GetUtils.isEmail(value) ? "Enter valid email" : null;
                          },
                          onSaved: (value){ user.businessEmail = value; },
                          decoration:
                          inputDecoration.copyWith(hintText: 'Enter business email ', labelText: 'Business email (if not applied default login email used)', hintMaxLines: 2),
                        ),
                        Divider(endIndent: 15),
                        SizedBox(height: 10),
                        TextFormField(
                          autofocus: false,
                          initialValue: user.phone.phone1 ?? "",
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                            FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                          ],
                          validator: (value) {
                            return !GetUtils.isPhoneNumber(value) ? "Enter valid Phone number" : null;
                          },
                          onSaved: (value){ user.phone.phone1 = value; },
                          decoration:
                          inputDecoration.copyWith(hintText: 'Enter phone number', labelText: 'Phone number'),
                        ),
                        Divider(endIndent: 15),
                        SizedBox(height: 10),
                        TextFormField(
                          autofocus: false,
                          initialValue: user.phone.phone2 ?? "",
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                            FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                          ],
                          validator: (value) {

                          },
                          onSaved: (value){ user.phone.phone2 = value; },
                          decoration:
                          inputDecoration.copyWith(hintText: 'Enter phone number', labelText: 'Phone number'),
                        ),
                        Divider(endIndent: 15),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: "Tanzania",
                          decoration: InputDecoration(
                            hintText: "Country",
                            labelText: "Country",
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
                        ButtonTheme(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minWidth: 200,
                          height: 45,
                          child: _isLoading ? CircularProgressIndicator() :RaisedButton(
                            child:Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed:() {
                              _updateUserInfo(user: user);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
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
