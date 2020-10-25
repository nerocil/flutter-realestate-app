import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:flutter_real_estate/services/http_service.dart';
import 'package:get/get.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextFieldController = TextEditingController();
  bool _autoValidate = false;
  bool _isLoading = false;
  bool _isReseted = false;
  final userController = Get.find<UserController>();

  _resetPassword() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _autoValidate = true;
        _isLoading = true;
      });

      final response = await HttpService().resetPassword(url: "/user/forgot/password", email: _emailTextFieldController.text);
      print(response.data);
      if (response.statusCode == 200) {
        final userResponse = UserResponse.fromJson(response.data);
        if (userResponse.error) {
          setState(() {
            _isLoading = false;
            _isReseted = false;
          });

          Get.snackbar("Oops!", userResponse.message, snackPosition: SnackPosition.BOTTOM);
          return;
        }

        setState(() {
        _isReseted = true;
        _isLoading = false;
      });

        return;
      }
      setState(() {
        _isLoading = false;
        _isReseted = false;
      });

      Get.snackbar("Oops!", "Something went wrong", snackPosition: SnackPosition.BOTTOM);
    }
  }

  var inputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    alignLabelWithHint: true,
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pinkAccent, width: 1), borderRadius: BorderRadius.circular(5)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pinkAccent, width: 1), borderRadius: BorderRadius.circular(5)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 1), borderRadius: BorderRadius.circular(5)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 1), borderRadius: BorderRadius.circular(5)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: _isReseted
                    ? Column(
                        children: [
                          Text(
                            "Reset Info",
                            style: Get.textTheme.headline6,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "We have emailed your password reset link",
                            style: Get.textTheme.caption,
                          ),
                          SizedBox(height: 15),
                          ButtonTheme(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            minWidth: 200,
                            height: 45,
                            child: RaisedButton(
                              child: Text(
                                "Open default email new",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                              onPressed: () async {
                                // Android: Will open mail app or show native picker.
                                // iOS: Will open mail app if single mail app found.
                                var result = await OpenMailApp.openMailApp();


                                // If no mail apps found, show error
                                if (!result.didOpen && !result.canOpen) {
                                  Get.snackbar("Oops!", "Cant open email please open manual",
                                      snackPosition: SnackPosition.BOTTOM, borderRadius: 10);

                                  // iOS: if multiple mail apps found, show dialog to select.
                                  // There is no native intent/default app system in iOS so
                                  // you have to do it yourself.
                                } else if (!result.didOpen && result.canOpen) {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return MailAppPickerDialog(
                                        mailApps: result.options,
                                      );
                                    },
                                  );
                                }
                                Get.back();
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      )
                    : Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "Reset Password",
                              style: Get.textTheme.headline6,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "If you dont remember your password enter your email below then tap reset",
                              style: Get.textTheme.caption,
                            ),
                            SizedBox(height: 15),
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
                              decoration:
                                  inputDecoration.copyWith(hintText: 'Enter your email address', labelText: 'Email'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ButtonTheme(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              minWidth: 200,
                              height: 45,
                              child: RaisedButton(
                                child: _isLoading ?  SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            strokeWidth: 2,
                                          )) : Text(
                                  "Reset Now",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                                disabledColor: Colors.blueGrey,
                                onPressed: _isLoading ? null: () async {
                                  _resetPassword();
                                },
                              ),
                            ),
                            SizedBox(height: 20),
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
