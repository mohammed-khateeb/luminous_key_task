import 'package:flutter/material.dart';
import '../Models/Api/user.dart';
import '../Models/Responses/httpresponse.dart';
import '../Services/auth_services.dart';
import '../Utils/user_utils.dart';

class AuthController with ChangeNotifier {
  User? user;
  bool waiting = true;

  Future<bool> login(
      String email, String password,) async {
    AuthServices authServices = AuthServices();

    User? response =
        await authServices.login(email, password,);
    if (response!=null) {
      setUserInformation(response);

      UserUtils.initCurrentUser(response);
      return true;
    }
    return false;

  }

  Future<bool> signUp(
      User user,) async {
    AuthServices authServices = AuthServices();

    User? response =
    await authServices.signUp(user);
    if (response!=null) {
      print(user.toJson());
      setUserInformation(response);

      UserUtils.initCurrentUser(response);
      return true;
    }
    return false;

  }

  signOut() {
    setUserInformation(null);

    UserUtils.signOut();

  }


  void setUserInformation(User? user) {
    this.user = user;
    notifyListeners();
  }
}
