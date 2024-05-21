import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<int?> get getStudentId async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('studentId');
  }

  static Future<void> setStudentId(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('studentId', value);
  }

  static Future<String> get getIne async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ine') ?? '';
  }

  static Future<void> setIne(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ine', value);
  }

  static Future<String> get getBirthdate async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('birthDate') ?? '';
  }

  static Future<void> setBirthDate(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('birthDate', value);
  }
}
