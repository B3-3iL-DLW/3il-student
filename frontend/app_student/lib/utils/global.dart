import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_student/api/users/models/user_model.dart';

class Global {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  static Future<SharedPreferences> get prefs async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    prefs.setString('user', userJson);
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    } else {
      return null;
    }
  }
}
