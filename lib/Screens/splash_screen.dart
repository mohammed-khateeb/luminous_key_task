import 'package:flutter/material.dart';
import 'package:luminous_key_task/Services/auth_services.dart';
import 'package:luminous_key_task/Utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/navigtor_utils.dart';
import '../../Utils/user_utils.dart';
import '../Controller/auth_controller.dart';
import '../Utils/main_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController? _authProvider;


  String? fcmToken;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthController>(context, listen: false);
    checkIfStayLogin();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset("assets/images/logo.png",width: size.width*0.6,),
        ),
      ),
    );
  }







  void checkIfStayLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");

    if (token != null) {
      await UserUtils.fetchUserInformationFromSharedToSingletonClass();
      NavigatorUtils.navigateToHomeScreen(MainUtils.navKey.currentContext!);
    } else {
      NavigatorUtils.navigateToStartScreen(MainUtils.navKey.currentContext!);

    }
  }
}
