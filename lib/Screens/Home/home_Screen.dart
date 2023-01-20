import 'package:flutter/material.dart';
import 'package:luminous_key_task/Controller/doctor_controller.dart';
import 'package:luminous_key_task/Localization/language_constants.dart';
import 'package:luminous_key_task/Models/Api/current_user.dart';
import 'package:luminous_key_task/Screens/Home/Components/doctor_component.dart';
import 'package:luminous_key_task/Utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'Components/home_app_bar.dart';
import 'Components/profile_picture_component.dart';
import 'Components/search_component.dart';
import 'Components/upcoming_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<DoctorController>().getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: size.height*0.06
        ),
        child: Stack(
          children: [
            SizedBox(height: size.height*0.06,child: HomeAppBar()),
            Container(
              height: size.height,
              width: size.width,
              margin: EdgeInsets.only(top: size.height*0.06),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xfff2f2f2),
                    ],
                  ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(size.height*0.03)
                )
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.08,),
                    RichText(
                      text: TextSpan(
                        text: getTranslated(context, "hello")!+", ",
                        style: TextStyle(
                          fontSize: size.height*0.024,
                          color: Colors.grey[800]
                      ),
                        children:  <TextSpan>[
                          TextSpan(text: CurrentUser.firstName!, style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.height*0.024)),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: size.height*0.03,
                        ),
                        SizedBox(width: size.width*0.02,),
                        Text(
                          "Irbid, Jordan",
                          style: TextStyle(
                            fontSize: size.height*0.02
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height*0.02,),
                    SearchComponent(),
                    SizedBox(height: size.height*0.03,),
                    DoctorComponent(),
                    SizedBox(height: size.height*0.015,),
                    UpcomingComponent(),
                    SizedBox(height: size.height*0.03,),

                  ],
                ),
              ),
            ),
            ProfilePictureComponent(),
          ],
        ),
      ),
    );
  }
}
