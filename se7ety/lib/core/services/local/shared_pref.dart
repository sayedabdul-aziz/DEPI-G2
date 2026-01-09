import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences prefs;

  static const kToken = 'token';
  static const kUserData = 'kUserData';
  static const kOnBoardingShown = 'onBoardingShown';
  static const kDarkTheme = 'darkTheme';

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setOnBoardingShown() {
    prefs.setBool(kOnBoardingShown, true);
  }

  static bool isOnBoardingShown() {
    return prefs.getBool(kOnBoardingShown) ?? false;
  }

  static setDarkTheme(bool isDark) {
    prefs.setBool(kDarkTheme, isDark);
  }

  static bool isDarkTheme() {
    return prefs.getBool(kDarkTheme) ?? false;
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
