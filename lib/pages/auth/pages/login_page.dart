import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_real_estate/controllers/navigation_bottom_controller.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:flutter_real_estate/common/appHelper.dart';
import 'package:flutter_real_estate/pages/auth/pages/register_page.dart';
import 'package:flutter_real_estate/pages/profile/pages/profile_page.dart';
import 'package:flutter_real_estate/services/http_service.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserController _userController = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();
  final _registerScaffoldKey = GlobalKey<ScaffoldState>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  bool _formAutoValidate = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    super.dispose();
  }

  _register() async {
    setState(() {
      _formAutoValidate = true;
      _isLoading = true;
    });

    if (_formKey.currentState.validate()) {
      final response = await HttpService().userAuth(
        url: '/user/login',
        user: User(
          country: "Tz",
          //todo make choice for country
          email: _emailTextFieldController.text,
          password: _passwordTextFieldController.text,
          passwordConfirmation: _passwordTextFieldController.text,
        ),
      );

      if (response.statusCode == 200) {
        final userResponse = UserResponse.fromJson(response.data);

        if (userResponse.error) {
          setState(() {
            _isLoading = false;
          });
          Get.snackbar(
            "Oops!",
            userResponse.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white.withAlpha(250),
            borderRadius: 10,
          );
          return;
        }

        await AppHelper.setToken(token: userResponse.user.token);
        String userToken = userResponse.user.token;
        userResponse.user.token = null;
        await AppHelper.setUser(user: userResponse.user);

        _userController.updateUser(user: userResponse.user);
        _userController.updateUserToken(token: userToken);

        Get.find<NavigationBottomController>().updateIndex(index: 3); // got to profile page

        Get.back();
      } else {
        Get.snackbar(
          "Oops!",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white.withAlpha(250),
          borderRadius: 10,
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  var inputDecoration = InputDecoration(
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
      key: _registerScaffoldKey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[100].withAlpha(245)),
                child: Form(
                  key: _formKey,
                  autovalidate: _formAutoValidate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Login",
                        style: Get.textTheme.headline6,
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: _emailTextFieldController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
                        validator: (String value) {
                          return !GetUtils.isEmail(value) ? "Enter valid email" : null;
                        },
                        decoration: inputDecoration.copyWith(hintText: 'Enter your email address', labelText: 'Email'),
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordTextFieldController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                        validator: (String value) {
                          return value.length == 0 ? "password required" : null;
                        },
                        decoration: inputDecoration.copyWith(hintText: 'Enter Password', labelText: 'Password'),
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ButtonTheme(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          height: 10,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                          child: FlatButton(
                            child: Text(
                              "Forgot password",
                              style: TextStyle(color: Colors.blue, fontFamily: "Medium"),
                            ),
                            onPressed: () {
                              //todo account password reset
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minWidth: 200,
                        height: 45,
                        child: _isLoading ? CircularProgressIndicator() :RaisedButton(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                                  _register();
                                },
                        ),
                      ),
                      SizedBox(height: 10),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: FlatButton(
                          child: Text(
                            "Don't have account",
                            style: TextStyle(color: Colors.blue, fontFamily: "Medium"),
                          ),
                          onPressed: () {
                            Get.off(RegisterPage());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
