import 'package:flutter/foundation.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  final userResponse = UserResponse().obs;
  final userToken = User().token.obs;

  updateUser({@required User user}){
    userResponse.update((value){
      value.user = user;
    });
  }

  updateUserToken({@required String token}){
    userToken.update((value){
      userToken.value = token;
    });
  }
}