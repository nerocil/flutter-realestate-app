import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

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
                padding: EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[100].withAlpha(245)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"))
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter your first name",
                          labelText: "First name",
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"))
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter your second name",
                          labelText: "Second name",
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter your email address",
                          labelText: "Email",
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          labelText: "Password",
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 10),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Already have account",
                              style: TextStyle(color: Colors.blue),
                            )),
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
