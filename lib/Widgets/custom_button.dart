import 'package:flutter/material.dart';

import '../Localization/current_language.dart';
import '../Utils/color_utils.dart';
import '../Utils/main_utils.dart';
import 'custom_inkwell.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final String? imagePath;
  final Function onPressed;
  final double? height;
  final double? width;
  final double? fontSize;

  final Color? color;
  final Border? border;
  final Color? textColor;
  final double? borderRadiusValue;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height,
    this.border,
    this.textColor,
    this.color,
    this.imagePath,
    this.width,
    this.borderRadiusValue, this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isTablet =
        MediaQuery.of(MainUtils.navKey.currentContext!).size.shortestSide >=
            550;
    return CustomInkwell(
      onTap: () => onPressed(),
      child: Container(
        height: height ?? size.height * 0.06,
        width: width ?? size.width * 0.55,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(
                  0, isTablet ? 6 : 3), // changes position of shadow
            ),
          ],
          color: color ?? kPrimaryColor,
          border: border,
          borderRadius:
              BorderRadius.all(Radius.circular(borderRadiusValue ?? 5)),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagePath != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(end: size.width * 0.02),
                  child: Image.asset(
                    imagePath!,
                    height: size.height * 0.025,
                    color: Colors.white,
                  ),
                ),
              Padding(
                padding:  EdgeInsets.only(
                  top: size.height*0.005
                ),
                child: Text(
                  label,
                  style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontFamily: "ExtraBold",
                    fontSize:fontSize?? size.height * (currentLanguageIsEnglish?0.02:0.018),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
