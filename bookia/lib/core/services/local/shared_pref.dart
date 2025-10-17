import 'dart:convert';

import 'package:bookia/features/auth/data/models/response/auth_response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences prefs;

  static const kToken = 'token';
  static const kUserData = 'kUserData';

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static saveToken(String? token) {
    if (token == null) return;
    setData(kToken, token);
  }

  static String? getToken() {
    return getData(kToken);
  }

  static setUserData(User? user) {
    if (user == null) return;
    // obj ==> toJson(encode) => String
    var objToJson = user.toJson();
    String userString = jsonEncode(objToJson);
    setData(kUserData, userString);
  }

  static User? getUserData() {
    var cachedString = getData(kUserData);
    if (cachedString == null) return null;

    // string(decode) ==> toJson => obj
    var stringToJson = jsonDecode(cachedString);
    return User.fromJson(stringToJson);
  }

  static setData(String key, dynamic value) {
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    }
  }

  static getData(String key) {
    return prefs.get(key);
  }
}
