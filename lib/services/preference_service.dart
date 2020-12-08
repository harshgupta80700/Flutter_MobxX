

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_mobxx/core/auth.dart';

class PreferencesService {
  static final PreferencesService _instance =
  new PreferencesService._internal();
  PreferencesService._internal();
  factory PreferencesService() => _instance;
  Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTH_TOKEN, token);
  }

  Future<String> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AUTH_TOKEN);
  }

  Future<bool> removeAuthToken() async {
    return (await this._getInstance()).remove(AUTH_TOKEN);
  }

  // setLoggedInUser(User user) async {
  //   (await this._getInstance())
  //       .setString(LOGGED_IN_USER, user.toMap().toString());
  // }

  // Future<String> getLoggedInUser() async {
  //   return (await this._getInstance()).getString(LOGGED_IN_USER);
  // }
  //
  // Future<bool> removeLoggedInUser() async {
  //   return (await this._getInstance()).remove(LOGGED_IN_USER);
  // }
}
