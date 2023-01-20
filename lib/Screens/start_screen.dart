import 'package:flutter/material.dart';
import 'package:luminous_key_task/Localization/language_constants.dart';
import 'package:luminous_key_task/Utils/color_utils.dart';
import 'package:luminous_key_task/Utils/navigtor_utils.dart';
import 'package:luminous_key_task/Widgets/custom_inkwell.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(kPrimaryColor.withOpacity(1), BlendMode.colorBurn),
                image: AssetImage(
                  "assets/images/start_background.jpg",
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  kPrimaryColor.withOpacity(0.2)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: size.height*0.4,
                ),
                SizedBox(height: size.height*0.03,),
                Text(
                  getTranslated(context, "care_cure_our_goal")!,
                  style: TextStyle(
                    fontSize: size.height*0.04,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height*0.06,),

                CustomInkwell(
                  onTap: (){
                    NavigatorUtils.navigateToLoginScreen(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.height*0.01),
                      color: Colors.white,

                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width*0.12,
                        vertical: size.height*0.018
                      ),
                      child: Text(
                        getTranslated(context, "get_started")!,
                        style: TextStyle(
                          fontSize: size.height*0.022,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.05,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
