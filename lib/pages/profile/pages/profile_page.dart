import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_real_estate/common/appHelper.dart';
import 'package:flutter_real_estate/common/app_button.dart';
import 'package:flutter_real_estate/common/color_coverter.dart';
import 'package:flutter_real_estate/controllers/user_controller.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:flutter_real_estate/pages/auth/pages/register_page.dart';
import 'package:flutter_real_estate/pages/profile/components/manage_account.dart';
import 'package:flutter_real_estate/pages/profile/components/my_client.dart';
import 'package:flutter_real_estate/pages/profile/components/my_dalali.dart';
import 'package:flutter_real_estate/pages/profile/components/profile_drawer.dart';
import 'package:flutter_real_estate/services/http_service.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profileScaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  bool _verifyBtn = false;
  bool _isVerify = false;
  bool _autoValidate = false;

  var _formValidateEmail = GlobalKey<FormState>();
  var _validationCode = TextEditingController();

  _getImageFile({@required bool isFromCamera}) async {
    var pickedFile;

    if (isFromCamera) {
      pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    } else {
      pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    }

    File file = File(pickedFile.path);

    if (file != null) {
      File croppedImage = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        cropStyle: CropStyle.rectangle,
        compressQuality: 80,
        compressFormat: ImageCompressFormat.jpg,
        maxWidth: 200,
        maxHeight: 200,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          toolbarTitle: "Edit image",
          showCropGrid: false,
          statusBarColor: Colors.white,
          backgroundColor: Colors.white,
        ),
      );

      if (croppedImage != null) {
        setState(() {
          _isLoading = true;
        });
      } else {
        return;
      }

      final userController = Get.find<UserController>();
      final response = await HttpService()
          .uploadUserImage(url: "/user/uploadImage/user", file: croppedImage, token: userController.userToken.value);

      print(userController.userToken.value);
      print(response.data);

      if (response.statusCode == 200) {
        final userResponse = UserResponse.fromJson(response.data);

        if (userResponse.error) {
          Get.snackbar("Oops!", "Could not upload image",
              backgroundColor: Colors.pink[100], snackPosition: SnackPosition.BOTTOM, borderRadius: 10);
          setState(() {
            _isLoading = false;
          });
          return;
        }

        await AppHelper.setUser(user: userResponse.user);
        userController.updateUser(user: userResponse.user);
        Get.snackbar("Successful", userResponse.message,
            backgroundColor: Colors.green[100], snackPosition: SnackPosition.BOTTOM, borderRadius: 10);
        setState(() {
          _isLoading = false;
        });
        return;
      }

      Get.snackbar("Oops!", "Could not upload image",
          backgroundColor: Colors.pink[100], snackPosition: SnackPosition.BOTTOM, borderRadius: 10);
      setState(() {
        _isLoading = false;
      });
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

  void _verifyEmail() async{
    if (_formValidateEmail.currentState.validate()) {
      final userController = Get.find<UserController>();
      _formValidateEmail.currentState.save();

      setState(() {
        _isVerify = true;
        _verifyBtn = false;
      });

      final response = await HttpService().validateEmail(
        url: '/user/verify/email',
        token: userController.userToken.value,
        code: _validationCode.text,
      );
      if (response.statusCode == 200) {
        final userResponse = UserResponse.fromJson(response.data);

        if (userResponse.error) {
          setState(() {
            _isVerify = false;
            _verifyBtn = true;
          });
          Get.snackbar("Oops!", userResponse.message,
              snackPosition: SnackPosition.BOTTOM);
          return;
        }

        AppHelper.setUser(user: userResponse.user);
        userController.updateUser(user: userResponse.user);
        setState(() {
          _isVerify = false;
          _verifyBtn = true;
        });
        return;

      }
      setState(() {
        _isVerify = false;
        _verifyBtn = true;
      });
      Get.snackbar("Oops!", "could not validate your email",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _profileScaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
          child: ProfileDrawer(),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return GetX<UserController>(builder: (userController) {
            return Stack(
              children: [
                Container(
                  height: constraints.maxHeight * .35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: HexColor('8896B0'),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
                ),
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: constraints.maxHeight * .13, left: 20, right: 20, bottom: 40),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blueGrey.withOpacity(.4),
                                    spreadRadius: -3,
                                    blurRadius: 20,
                                    offset: Offset(0, 5))
                              ]),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    child: InkWell(
                                      onTap: () async {
                                        await Get.defaultDialog(
                                          title: "User profile image",
                                          middleText: "Select image source below",
                                          radius: 10,
                                          actions: [
                                            ButtonTheme(
                                              child: FlatButton.icon(
                                                label: Text("Camera",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                    )),
                                                onPressed: () {
                                                  _getImageFile(isFromCamera: true);
                                                  Get.back();
                                                },
                                                icon: Icon(Icons.camera, color: Colors.blue),
                                              ),
                                            ),
                                            ButtonTheme(
                                              child: FlatButton.icon(
                                                label: Text("Gallery",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                    )),
                                                onPressed: () {
                                                  _getImageFile(isFromCamera: false);
                                                  Get.back();
                                                },
                                                icon: Icon(Icons.folder, color: Colors.blue),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: userController.userData.value.image == null
                                                    ? AssetImage("assets/images/default.jpg")
                                                    : NetworkImage(
                                                        HttpService.imageUrl + userController.userData.value.image),
                                                fit: BoxFit.cover),
                                          ),
                                          child: _isLoading
                                              ? Center(
                                                  child: SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ))
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${userController.userData.value.name}",
                                          style: Get.textTheme.headline6.copyWith(fontFamily: "Medium"),
                                        ),
                                        Text(
                                          "${userController.userData.value.email}",
                                          style: TextStyle(color: Colors.grey, fontSize: 13),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.blueGrey.withOpacity(.2),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "Property",
                                                    style: TextStyle(
                                                        color: Colors.blueGrey, fontFamily: "medium", fontSize: 14),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "12",
                                                    style: Get.textTheme.headline6.copyWith(fontFamily: "Medium"),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Available",
                                                    style: TextStyle(
                                                        color: Colors.blueGrey, fontFamily: "medium", fontSize: 14),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "4",
                                                    style: Get.textTheme.headline6.copyWith(fontFamily: "Medium"),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Dalali",
                                                    style: TextStyle(
                                                        color: Colors.blueGrey, fontFamily: "medium", fontSize: 14),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "2",
                                                    style: Get.textTheme.headline6.copyWith(fontFamily: "Medium"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: ButtonTheme(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      child: OutlineButton(
                                        onPressed: () {
                                          _profileScaffoldKey.currentState.openDrawer();
                                        },
                                        child: Text(
                                          "Manage",
                                          style: TextStyle(fontFamily: "medium"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: ButtonTheme(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      child: FlatButton(
                                        color: Colors.blue,
                                        onPressed: () {},
                                        child: Text(
                                          "Upgrade now",
                                          style: TextStyle(fontFamily: "medium", color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        MyProperty(),
                        MyClient(),
                        MyDalali(),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[600], boxShadow: []),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: AssetImage("assets/images/be_pro.jpg"),
                                        height: 105,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Become Pro",
                                          style: Get.textTheme.headline6
                                              .copyWith(fontFamily: "Medium", color: Colors.white),
                                        ),
                                        Text(
                                          "Get more done with pro",
                                          style: TextStyle(color: Colors.grey[400], fontFamily: "medium", fontSize: 15),
                                        ),
                                        SizedBox(height: 25),
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
                      ],
                    ),
                  ),
                ),
                userController.userData.value.emailVerifiedAt == null
                    ? Stack(
                        children: [
                          Container(
                            color: Colors.black.withAlpha(180),
                          ),
                          Positioned(
                            left: 10,
                            right: 10,
                            bottom: 20,
                            //top: 20,
                            child: Container(
                              padding: EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[100].withAlpha(245)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.blueGrey,
                                        child: Text(userController.userData.value.firstName[0], style: Get.textTheme.headline6.copyWith(color: Colors.white),),
                                      ),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userController.userData.value.firstName+' '+userController.userData.value.lastName,
                                            style: Get.textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            userController.userData.value.email,
                                            style: Get.textTheme.bodyText2,
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.blueGrey,),
                                  Text(
                                    "We have emailed your verification code!",
                                    style: Get.textTheme.caption,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: AppButton(
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                        onTap: () async {
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
                                              builder: _isVerify ? null : (_) {
                                                return MailAppPickerDialog(
                                                  mailApps: result.options,
                                                );
                                              },
                                            );
                                          }
                                        },
                                        text: "Open default email app now"),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Form(
                                    key: _formValidateEmail,
                                    autovalidate: _autoValidate,
                                    child: TextFormField(
                                      autofocus: false,
                                      controller: _validationCode,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp(r"\s")),
                                        FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          value.trim().length > 3 ? _verifyBtn = true : _verifyBtn = false;
                                        });
                                      },
                                      validator: (String value) {
                                        return value.trim().isEmpty ? "Code number required" : null;
                                      },
                                      decoration: inputDecoration.copyWith(
                                          hintText: 'Verification code', labelText: 'Enter Verification Code'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ButtonTheme(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    minWidth: 200,
                                    height: 45,
                                    child: RaisedButton(
                                      disabledColor: !_verifyBtn ? Colors.blueGrey :Colors.blue,
                                      color: Colors.blue,
                                      child: _isVerify ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            strokeWidth: 2,
                                          )) :Text(
                                        "Verify now",
                                        style: TextStyle(color: Colors.white),
                                      ),

                                      onPressed: !_verifyBtn ? null :() async {
                                              _verifyEmail();
                                            },
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("If wrong email address then "),
                                      AppButton(
                                        text: "try another",
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        textFontSize: 12,
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        onTap: (){
                                          Get.to(RegisterPage());
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            );
          });
        }),
      ),
    );
  }


}
