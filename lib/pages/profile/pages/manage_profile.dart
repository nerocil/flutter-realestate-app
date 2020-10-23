import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_real_estate/common/appHelper.dart';
import 'package:flutter_real_estate/controllers/navigation_bottom_controller.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:flutter_real_estate/pages/auth/pages/login_page.dart';
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
  bool _onLogout = false;
  String selectedCountry;

  final  countries = {
    "Tz": "Tanzania",
    "Bw": "Botswana"
  };

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
                      color: Colors.blue[700],
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
              builder: (userController) {
                final user = userController.userData.value;
                return Column(
                  children: [
                    Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.only(top: 20, left: 20, bottom: 0, right: 0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight:Radius.circular(10)), color: Colors.blueGrey[100]),
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
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: userController.userData.value.image == null
                                                      ? AssetImage("assets/images/default.jpg")
                                                      : NetworkImage(
                                                      HttpService.imageUrl + userController.userData.value.image),
                                                  fit: BoxFit.cover
                                                )
                                              ),
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
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(r"\s")),
                                    FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                                  ],
                                  validator: (value) {
                                      return value.length < 9 ? "Enter valid phone number" :null;
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
                                  onSaved: (value){ user.phone.phone2 = value; },
                                  decoration:
                                  inputDecoration.copyWith(hintText: 'Enter phone number', labelText: 'Phone number'),
                                ),
                                Divider(endIndent: 15),
                                SizedBox(height: 10),
                                FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: inputDecoration
                                          .copyWith(labelText: "Select country", hintText: "Select country"),
                                      //isEmpty: false,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          items: countries.entries
                                              .map<DropdownMenuItem<String>>(
                                                  (MapEntry<String, String> e) => DropdownMenuItem<String>(
                                                value: e.key,
                                                child: Text( e.value ),
                                              ))
                                              .toList(),

                                          icon: Icon(Icons.list, color: Colors.transparent,),
                                          value: selectedCountry ?? user.country?? "Tz",
                                          onChanged: (String value) {
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            setState(() {
                                              selectedCountry = value;
                                            });
                                            user.country = value;
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ButtonTheme(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight:Radius.circular(10))),
                        padding:  EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 20),
                        child:FlatButton(
                          color: Colors.blue,
                          disabledColor: Colors.blueGrey[100],
                          onPressed: _isLoading ? null:(){
                            _updateUserInfo(user: user);
                            },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isLoading ? SizedBox(height:20, width:20,child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2,)) :Text(
                                "Update",
                                style: Get.textTheme.headline6.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
                      color: Colors.blue[700],
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
                      color: Colors.blue[700],
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
                        "Some action may leading of loosing of your data",
                        style: Get.textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ButtonTheme(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding:  EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 20),
                child: FlatButton(
                  color: Colors.blue,
                  disabledColor: Colors.blue,
                  onPressed: _onLogout ? null :() async{

                    setState(() {
                      _onLogout = true;
                    });
                    final userController = Get.find<UserController>();
                    final response = await HttpService().userLogout(url: "/user/logout", token: userController.userToken.value);
                    print("On login-out ## ${response.data}");

                    userController.updateUserToken(token: null);

                    Get.find<NavigationBottomController>().updateIndex(index: 0);
                    Navigator.of(context).pop();
                    AppHelper.removeLocalData();
                    Get.to(LoginPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _onLogout ? SizedBox(height:20, width:20,child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2,)) :Text(
                        "Logout",
                        style: Get.textTheme.headline6.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
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
