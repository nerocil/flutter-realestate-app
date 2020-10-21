import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_real_estate/common/appHelper.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  final userData = User().obs;
  var userToken = User().token.obs;


  @override
  void onInit() {
    super.onInit();
    getCredential();
  }

  void getCredential() async {
    String jsonUser = await AppHelper.getUser();
    String token = await AppHelper.getToken();
    if (token != null) {
      updateUser(user: User.fromJson(jsonDecode(jsonUser)));
      updateUserToken(token: token);

      print(userToken.value);
      print(userData.value.email);

    }
  }
  updateUser({@required User user}){
    userData.update((value) {
      value.id = user.id;
      value.roleId = user.roleId;
      value.subscriptionId = user.subscriptionId;
      value.accountType = user.accountType;
      value.name = user.name;
      value.firstName = user.firstName;
      value.lastName = user.lastName;
      value.phone = user.phone;
      value.country = user.country;
      value.businessEmail = user.businessEmail;
      value.image = user.image;
      value.email = user.email;
      value.password = user.password;
      value.passwordConfirmation = user.passwordConfirmation;
      value.emailVerifiedAt = user.emailVerifiedAt;
      value.favorites = user.favorites;
      value.client = user.client;
      value.dalali = user.dalali;
      value.status = user.status;
      value.deletedAt = user.deletedAt;
      value.createdAt = user.createdAt;
      value.updatedAt = user.updatedAt;
      value.token = user.token;
    });
  }

  updateUserToken({@required String token}){
      userToken.value = token;
  }
}