import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_estate/models/user_response.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;


class AppHelper {
  static const String _TOKEN = 'token';
  static const String _USER = 'user';
  static final scrollController = ScrollController();



  static bool isUrl({@required String url}) {
    return RegExp(
        r"^[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)")
        .hasMatch(url);
  }


  static priceFormat({@required double price}) {
    final moneyFormatter = new NumberFormat("#,##0", "en_US");
    return moneyFormatter.format(price);
  }

  static String timeAgo({@required String time}){
    return timeago.format(DateTime.parse(time),
        locale: 'en', allowFromNow: true);
  }

  static setToken({@required String token}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(_TOKEN, token);
  }

  static setUser({@required User user}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(_USER, jsonEncode(user));
  }

  static getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.get(_TOKEN);
  }

  static getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.get(_USER);
  }

  static removeLocalData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove(_TOKEN);
    localStorage.remove(_USER);
  }
}