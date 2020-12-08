import 'package:flutter/cupertino.dart';
import 'package:todo_mobxx/presentations/auth/login.dart';

class AppRoutes{
  static const LOGIN = "/login.dart";
  static const SIGN_UP = "/signUp";

}

Map<String,WidgetBuilder> routes = {
  AppRoutes.LOGIN: (context) => Login()
};