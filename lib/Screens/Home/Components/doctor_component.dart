import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luminous_key_task/Controller/doctor_controller.dart';
import 'package:luminous_key_task/Utils/main_utils.dart';
import 'package:luminous_key_task/Utils/navigtor_utils.dart';
import 'package:luminous_key_task/Widgets/custom_inkwell.dart';
import 'package:luminous_key_task/Widgets/waiting_widget.dart';
import 'package:provider/provider.dart';

import '../../../Utils/color_utils.dart';
import '../../../Widgets/reusable_cached_network_image.dart';

class DoctorComponent extends StatelessWidget {
  const DoctorComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<DoctorController>(
        builder: (context, doctorControllerData, _) {
      return doctorControllerData.waiting
          ? const WaitingWidget()
          : ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: doctorControllerData.doctors!.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.02,
                          vertical: size.height * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(size.height * 0.035)),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: AlignmentDirectional.centerEnd,
                          end: AlignmentDirectional.centerStart,
                          colors: [
                            Colors.white,
                            Color(0xfff2f2f2),
                          ],
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableCachedNetworkImage(
                            imageUrl: doctorControllerData
                                .doctors![index].doctorImageURL,
                            height: size.height * 0.11,
                            width: size.height * 0.11,
                            borderRadius: BorderRadius.circular(size.height),
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text(
                                  doctorControllerData
                                      .doctors![index].doctorName!,
                                  style: TextStyle(
                                      fontSize: size.height * 0.022,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.012,
                                ),
                                CustomInkwell(
                                  onTap: (){
                                    MainUtils.sendEmail(doctorControllerData
                                        .doctors![index].doctorEmail!);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.mail_outline,
                                        size: size.height * 0.02,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.015,
                                      ),
                                      Expanded(
                                        child: Text(
                                          doctorControllerData
                                              .doctors![index].doctorEmail!,
                                          style: TextStyle(
                                            fontSize: size.height * 0.015,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.012,
                                ),
                                CustomInkwell(
                                  onTap: (){
                                    MainUtils.makeCall(doctorControllerData
                                        .doctors![index].phoneNumber!);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        size: size.height * 0.02,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.015,
                                      ),
                                      Expanded(
                                        child: Text(
                                          doctorControllerData
                                              .doctors![index].phoneNumber!,
                                          style: TextStyle(
                                            fontSize: size.height * 0.015,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.009,
                                ),
                                CustomInkwell(
                                  onTap: () {
                                    NavigatorUtils.navigateToMapScreen(context,
                                        address: LatLng(
                                            double.parse(doctorControllerData
                                                .doctors![index]
                                                .address!
                                                .latitude!),
                                            double.parse(doctorControllerData
                                                .doctors![index]
                                                .address!
                                                .longitude!)));
                                  },
                                  child: Text(
                                    "${doctorControllerData.doctors![index].address!.city}, ${doctorControllerData.doctors![index].address!.country}",
                                    style: TextStyle(
                                        fontSize: size.height * 0.015,
                                        color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(size.height * 0.035)),
                        color: kPrimaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                size: size.height * 0.02,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: size.width * 0.015,
                              ),
                              Text(
                                "Monday - june 22",
                                style: TextStyle(
                                  fontSize: size.height * 0.015,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: size.height * 0.02,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: size.width * 0.015,
                              ),
                              Text(
                                "08:00 PM",
                                style: TextStyle(
                                  fontSize: size.height * 0.015,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                );
              },
            );
    });
  }
}
