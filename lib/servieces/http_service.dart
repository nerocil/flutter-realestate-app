import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_real_estate/models/user_response.dart';

/*
this class is for http request. all request are use Dio package
*/

class HttpService{
  ///live server
  // static final String baseUrl = "",
  //     imageUrl = "";

  /*
  Local server dev test
  you may need to change the IP address according to yours.
  medias are stored in public folder in server so imageUrl is defined
  */
 static final String baseUrl = "http://192.168.43.62/api/v1",
     imageUrl = "http://192.168.43.62";
 

 /*
 variable string token is used for assigned token for request when need
 some of request url are public without auth needed
 */
  String token;


  BaseOptions dioOption() {
    BaseOptions options = new BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
      headers: {
        Headers.acceptHeader: Headers.jsonContentType,
        Headers.contentTypeHeader: Headers.jsonContentType,
        "Authorization": "Bearer $token",
        "version": "1.0.0" // todo in future we may need this for check app version for notify user if app update needed
      },
    );
    return options;
  }

  /*
   this function in both used for register and login accept url string and user model
   */

  Future<Response> userAuth({@required String url, @required User user}) async {
    Dio dio = Dio(dioOption());
    return await dio.post(url, data: user.toJson());
  }
}