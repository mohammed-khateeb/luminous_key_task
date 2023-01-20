import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luminous_key_task/Screens/Auth/signup_screen.dart';
import 'package:luminous_key_task/Screens/Home/home_Screen.dart';
import 'package:luminous_key_task/Screens/map_screen.dart';
import 'package:luminous_key_task/Screens/start_screen.dart';
import 'package:provider/provider.dart';

import '../Screens/Auth/login_screen.dart';

class NavigatorUtils {
  static void navigateToLoginScreen(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
  static void navigateToHomeScreen(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false);
  }

  static void navigateToStartScreen(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const StartScreen()),
            (Route<dynamic> route) => false);
  }

  static void navigateToMapScreen(context,{required LatLng address}) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>  MapScreen(address: address)));
  }

  static void navigateToSignUpScreen(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }
}
