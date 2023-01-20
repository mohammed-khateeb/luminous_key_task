import 'package:flutter/material.dart';
import 'package:luminous_key_task/Localization/current_language.dart';

import '../../../Localization/language_constants.dart';
import '../../../Utils/color_utils.dart';
import '../../../Widgets/reusable_cached_network_image.dart';
import 'dart:math' as math;

class UpcomingComponent extends StatelessWidget {
  const UpcomingComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.05,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, "upcoming_appointment")!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.height*0.017,
                ),
              ),
              Text(
                getTranslated(context, "see_all")!,
                style: TextStyle(
                    fontSize: size.height*0.017,
                    color: kPrimaryColor
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height*0.03,),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width*0.05,
              vertical: size.height*0.02
          ),
          width: size.width,
          color: Colors.white,
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    height: size.height*0.16,
                    width: size.width*0.36,
                    decoration: BoxDecoration(
                      color: Color(0xfff7d9de),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(4, 4), // changes position of shadow
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(4, 4), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(size.height*0.02),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReusableCachedNetworkImage(
                          imageUrl: "https://ichef.bbci.co.uk/news/976/cpsprodpb/C91C/production/_127948415_bird-china-gettyimages-1447284840.jpg",
                          height: size.height*0.07,
                          width: size.height*0.07,
                          borderRadius: BorderRadius.circular(size.height),
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "Dr. Salma azzam",
                          style: TextStyle(fontSize: size.height*0.017,fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.date_range_outlined,
                                  size: size.height*0.016,
                                ),
                                SizedBox(width: size.width*0.015,),
                                Text(
                                  "Monday - june 22",
                                  style: TextStyle(
                                    fontSize: size.height*0.013,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height*0.007,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: size.height*0.016,
                                ),
                                SizedBox(width: size.width*0.015,),
                                Text(
                                  "08:00 PM",
                                  style: TextStyle(
                                    fontSize: size.height*0.013,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: size.width*0.05,),
                  Container(
                    height: size.height*0.16,
                    width: size.width*0.36,
                    decoration: BoxDecoration(
                      color: Color(0xfff7d9de),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(4, 4), // changes position of shadow
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(4, 4), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(size.height*0.02),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReusableCachedNetworkImage(
                          imageUrl: "https://ichef.bbci.co.uk/news/976/cpsprodpb/C91C/production/_127948415_bird-china-gettyimages-1447284840.jpg",
                          height: size.height*0.07,
                          width: size.height*0.07,
                          borderRadius: BorderRadius.circular(size.height),
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "Dr. Zaher abd",
                          style: TextStyle(fontSize: size.height*0.017,fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.date_range_outlined,
                                  size: size.height*0.016,
                                ),
                                SizedBox(width: size.width*0.015,),
                                Text(
                                  "Monday - june 22",
                                  style: TextStyle(
                                    fontSize: size.height*0.013,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height*0.007,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: size.height*0.016,
                                ),
                                SizedBox(width: size.width*0.015,),
                                Text(
                                  "08:00 PM",
                                  style: TextStyle(
                                    fontSize: size.height*0.013,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              PositionedDirectional(
                bottom: 0,
                end: 0,
                height: size.height*0.16,
                child: RotatedBox(
                  quarterTurns: currentLanguageIsEnglish?1:-1,
                  child: Container(
                    height: size.width*0.08,
                    width: size.height*0.16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height*0.01),
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text(
                        getTranslated(context, "make_a_new")!,
                        style: TextStyle(
                            fontSize: size.height*0.018,
                            color: kPrimaryColor
                        ),
                      ),
                    ),

                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
