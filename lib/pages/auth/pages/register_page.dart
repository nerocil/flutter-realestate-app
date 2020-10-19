import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:flutter_real_estate/common/appHelper.dart';
import 'package:flutter_real_estate/servieces/http_service.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        final requestResponse = UserResponse.fromJson(response.data);

        print(response.data);

        if (requestResponse.error) {
          setState(() {
            _isLoading = false;
          });
          Get.snackbar(
            "Oops!",
            requestResponse.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white.withAlpha(250),
            borderRadius: 10,
          );
          return;
        }

        await AppHelper.setToken(token: requestResponse.user.token);
        requestResponse.user.token = null;
        await AppHelper.setUser(user: requestResponse.user);

        //todo use Get.off(<to page>) page to remove this screen from stack

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
                padding: EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[100].withAlpha(245)),
                child: Form(
                  key: _formKey,
                  autovalidate: _formAutoValidate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
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
                      Divider(endIndent: 15),
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
                      Divider(endIndent: 15),
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
                      Divider(endIndent: 15),
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
                      Divider(endIndent: 15),
                      SizedBox(height: 10),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minWidth: 200,
                        height: 45,
                        child: RaisedButton(
                          child: Text(
                            _isLoading ? "Loading..." : "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed: _isLoading
                              ? null
                              : () {
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
                          onPressed: () {},
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
