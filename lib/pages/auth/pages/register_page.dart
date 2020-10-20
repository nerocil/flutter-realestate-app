import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_real_estate/controllers/navigation_bottom_controller.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:flutter_real_estate/common/appHelper.dart';
import 'package:flutter_real_estate/pages/auth/pages/login_page.dart';
import 'package:flutter_real_estate/services/http_service.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final UserController _userController = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();
  final _registerScaffoldKey = GlobalKey<ScaffoldState>();
  final _firstNameTextFieldController = TextEditingController();
  final _lastNameTextFieldController = TextEditingController();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  bool _formAutoValidate = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameTextFieldController.dispose();
    _lastNameTextFieldController.dispose();
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
        url: '/user/register',
        user: User(
          country: "Tz",
          //todo make choice for country
          firstName: _firstNameTextFieldController.text,
          lastName: _lastNameTextFieldController.text,
          email: _emailTextFieldController.text,
          password: _passwordTextFieldController.text,
          passwordConfirmation: _passwordTextFieldController.text,
        ),
      );

      if (response.statusCode == 200) {
        //todo validate email account
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

        Get.find<NavigationBottomController>().updateIndex(index: 3);// got to profile page

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
                      SizedBox(height: 10),
                      Text(
                        "Create Account",
                        style: Get.textTheme.headline6,
                      ),

                      TextFormField(
                        autofocus: false,
                        controller: _firstNameTextFieldController,
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
                        decoration:
                            inputDecoration.copyWith(hintText: 'Enter your first name', labelText: 'First name'),
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      TextFormField(
                        autofocus: false,
                        controller: _lastNameTextFieldController,
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
                        decoration: inputDecoration.copyWith(hintText: 'Enter your last name', labelText: 'Last name'),
                      ),
                      Divider(),
                      SizedBox(height: 10),
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
                          return value.length < 8 ? "At least 8 characters required" : null;
                        },
                        decoration: inputDecoration.copyWith(hintText: 'Enter Password', labelText: 'Password'),
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minWidth: 200,
                        height: 45,
                        child: _isLoading ? CircularProgressIndicator() :RaisedButton(
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed:() {
                                  _register();
                                },
                        ),
                      ),
                      SizedBox(height: 10),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: FlatButton(
                          child: Text(
                            "Already have account",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Get.off(LoginPage());
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
