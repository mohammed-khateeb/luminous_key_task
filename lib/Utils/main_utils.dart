import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Localization/language_constants.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_progress_dialog.dart';
import 'color_utils.dart';

class MainUtils {
  static final navKey = GlobalKey<NavigatorState>();

  static showCustomDialog(Widget dialogWidget,{bool barrierDismissible = true}) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: navKey.currentState!.context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => dialogWidget,
    );
  }


  static sendEmail(String email) async {
    if (!await launchUrl(Uri.parse("mailto:$email"))) {
      throw 'Could not mailto $email';
    }
  }

  static makeCall(String phoneNumber) async {
    if (!await launchUrl(Uri.parse("tel:$phoneNumber"))) {
      throw 'Could not call $phoneNumber';
    }
  }


  static final CustomProgressDialog _progressDialog =
  CustomProgressDialog(context: navKey.currentState!.overlay!.context);

  static showWaitingProgressDialog({bool forRegister = false}) {
    _progressDialog.show(
      progressBgColor: Colors.white,
      msgFontSize: 20,
      msg: getTranslated(navKey.currentState!.overlay!.context, 'please_wait')!,
      max: double.maxFinite.round(),
      progressValueColor: kPrimaryColor,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10,
    );
  }

  static hideWaitingProgressDialog() {
    _progressDialog.close();
  }


  static showErrorAlertDialog(String msg,{Widget? secondButton}) {
    Size size = MediaQuery.of(navKey.currentState!.context).size;
    bool isTablet =
        MediaQuery.of(MainUtils.navKey.currentContext!).size.shortestSide >=
            550;

    showGeneralDialog(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      barrierLabel: "close",
      context: navKey.currentState!.context,
      pageBuilder: (_, __, ___) {
        return const Center();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              titlePadding: EdgeInsetsDirectional.only(
                  end: size.height * 0.015, top: isTablet ? size.height * 0.0 : size.height * 0.015),
              insetPadding: isTablet
                  ? EdgeInsets.only(
                  left: size.width * 0.21,
                  right: size.width * 0.21,
                  top: size.height * 0.21,
                  bottom: size.height * 0.21)
                  : const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
              contentPadding: EdgeInsets.symmetric(
                  vertical: isTablet ? size.height * 0.0 : size.height * 0.022,
                  horizontal: isTablet ? size.width * 0.0 : size.width * 0.035),
              content: Padding(
                padding: isTablet ? EdgeInsetsDirectional.only(bottom: size.height * 0.03) : EdgeInsets.all(0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: isTablet ? EdgeInsets.all(12.0) : EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              size: size.height * 0.025,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: isTablet ? EdgeInsetsDirectional.only(start: size.width * 0.04,end: size.width * 0.04) : EdgeInsetsDirectional.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            height: size.height * 0.095,
                            width: size.height * 0.095,
                            decoration: const BoxDecoration(
                                color: kPrimaryColor,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: size.height * 0.065,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Text(
                            msg,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: size.height * 0.0195,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.height * 0.045,
                          ),
                          CustomButton(
                            width: size.width * 0.41,
                            height: size.height * 0.047,
                            label: getTranslated(context, "done")!,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),

                          if(secondButton!=null)Padding(
                            padding: EdgeInsets.only(top: size.height*0.015),
                            child: secondButton,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static showSuccessAlertDialog(String msg) {
    Size size = MediaQuery.of(MainUtils.navKey.currentContext!).size;

    bool isTablet =
        MediaQuery.of(MainUtils.navKey.currentContext!).size.shortestSide >=
            550;

    showGeneralDialog(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      barrierLabel: "close",
      context: navKey.currentState!.context,
      pageBuilder: (_, __, ___) {
        return const Center();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              titlePadding: EdgeInsetsDirectional.only(
                  end: size.height * 0.015, top: isTablet ? size.height * 0.0 : size.height * 0.015),
              insetPadding: isTablet
                  ? EdgeInsets.only(
                  left: size.width * 0.21,
                  right: size.width * 0.21,
                  top: size.height * 0.21,
                  bottom: size.height * 0.21)
                  : const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
              contentPadding: EdgeInsets.symmetric(
                  vertical: isTablet ? size.height * 0.0 : size.height * 0.022,
                  horizontal: isTablet ? size.width * 0.0 : size.width * 0.035),
              content: Padding(
                padding: isTablet ? EdgeInsetsDirectional.only(bottom: size.height * 0.03) : EdgeInsets.all(0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Padding(
                    //   padding: isTablet ? EdgeInsets.all(12.0) : EdgeInsets.all(0.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //         },
                    //         child: Icon(
                    //           Icons.close,
                    //           size: size.height * 0.025,
                    //           color: Colors.grey,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: isTablet ? EdgeInsetsDirectional.only(start: size.width * 0.04,end: size.width * 0.04) : EdgeInsetsDirectional.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          // Container(
                          //   height: size.height * 0.095,
                          //   width: size.height * 0.095,
                          //   decoration: const BoxDecoration(
                          //       color: kPrimaryColor,
                          //       shape: BoxShape.circle),
                          //   child: Icon(
                          //     Icons.done,
                          //     color: Colors.white,
                          //     size: size.height * 0.065,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.015,
                          // ),
                          // Text(
                          //   getTranslated(context, "done")!,
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       color: kPrimaryColor,
                          //       fontSize: size.height * 0.02,
                          //       fontWeight: FontWeight.w600),
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.035,
                          // ),
                          Image.asset(
                            "assets/images/success_animation.gif",
                            height: size.height*0.2,
                          ),
                          Text(
                            msg,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: size.height * 0.0195,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.height * 0.045,
                          ),
                          CustomButton(
                            width: size.height * 0.14,
                            height: size.height * 0.047,
                            label: getTranslated(context, "done")!,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
