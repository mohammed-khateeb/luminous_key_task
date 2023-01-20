import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Localization/language_constants.dart';
import '../Utils/color_utils.dart';
import '../Utils/main_utils.dart';
import 'custom_decorated_input_border.dart';

class CustomTextField extends StatelessWidget {
  final dynamic validator;
  final dynamic suffixIcon;
  final dynamic onTap;
  final dynamic hintText;
  final dynamic obscureText;
  final dynamic controller;
  final List<String>? dropList;
  final int? minLines;
  final bool readOnly;
  final bool isMobileNumber;
  final bool withValidate;
  final String? label;
  final IconData? labelIcon;
  final bool isRequired;
  final bool? digitOnly;
  final int? lengthLimiting;
  final double? width;
  final double? height;
  final double? hintSize;
  final Function? onChanged;
  final TextInputType? textInputType;
  final int? maxLength;
  final bool? isEnabled;
  final Color? labelColor;
  final double? vertical;
  final Widget? subLabel;

  const CustomTextField(
      {Key? key,
      this.validator,
      this.suffixIcon,
      this.hintText,
      this.obscureText,
      this.controller,
      this.readOnly = false,
      this.digitOnly = false,
      this.lengthLimiting,
      this.onChanged,
      this.textInputType,
      this.maxLength,
      this.onTap,
      this.label,
      this.isRequired = false,
      this.withValidate = false,
      this.isMobileNumber = false,
      this.width,
      this.hintSize,
      this.isEnabled, this.dropList, this.labelIcon, this.labelColor, this.height, this.minLines, this.subLabel, this.vertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isTablet =
        MediaQuery.of(MainUtils.navKey.currentContext!).size.shortestSide >=
            550;
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      bottom: size.height * 0.005, start: 1.5),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 2,
                    children: [
                      if (labelIcon!=null)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: size.height*0.005,

                          ),
                          child: Icon(
                            labelIcon!,
                            size: size.height*0.02,
                            color: Colors.grey[600],
                          ),
                        ),
                      Text(
                        label!,
                        style: TextStyle(
                            color: labelColor ?? Colors.grey[700],
                            fontSize: size.height * (isTablet ? 0.017 : 0.022)),
                      ),
                      if (isRequired)
                        Text(
                          "*",
                          style: TextStyle(
                              color: Colors.red[900],
                              fontSize: size.height * 0.0165),
                        ),

                    ],
                  ),
                ),
                subLabel??const SizedBox()
              ],
            ),
          Center(
            child: Stack(
              children: [
                TextFormField(
                  minLines: minLines??1,
                  maxLines: minLines??1,

                  textAlignVertical: TextAlignVertical.bottom,
                  style: TextStyle(
                      fontSize: isTablet ? size.height * 0.017 : size.height * 0.02,
                    height :1.5
                  ),
                  controller: controller,
                  validator: withValidate && validator == null
                      ? (value) {
                          if (value!.toString().trim().isEmpty) {
                            return getTranslated(context, "can_not_empty");
                          }
                          return null;
                        }
                      : validator,
                  onTap: onTap,
                  obscureText: obscureText ?? false,
                  readOnly: readOnly,
                  keyboardType: digitOnly! ?TextInputType.number : null,

                  onChanged: (str) => onChanged != null ? onChanged!(str) : null,
                  cursorColor: kPrimaryColor,
                  inputFormatters: digitOnly != null && digitOnly!
                      ? [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          maxLength == null
                              ? LengthLimitingTextInputFormatter(999999)
                              : LengthLimitingTextInputFormatter(maxLength),
                        ]
                      : [
                          maxLength == null
                              ? LengthLimitingTextInputFormatter(999999)
                              : LengthLimitingTextInputFormatter(maxLength),
                        ],
                  decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      enabled: isEnabled ?? true,
                      errorStyle: TextStyle(
                          fontSize: size.height * (isTablet ? 0.013 : 0.017)),


                      fillColor: Colors.grey[300],
                      hintText: isMobileNumber && hintText == null
                          ? "7 ********"
                          : hintText,
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: hintSize ?? size.height * 0.02,
                      ),
                     // isCollapsed: isMobileNumber,

                      border: DecoratedInputBorder(
                        child: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(size.height * 0.005),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        shadow: BoxShadow(
                          color: Colors.grey[100]!,
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.only(
                        end: size.width * 0.025,
                        start:isMobileNumber?size.width*0.17: size.width * 0.025,
                        bottom: vertical??  size.height * 0.01,
                        top: vertical?? size.height * 0.01,
                      ),
                  ),

                ),
                if(suffixIcon!=null)
                  Positioned.fill(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: size.width*0.03,
                        ),
                        child: suffixIcon,
                      ),
                    ),
                  ),
                if(isMobileNumber)
                  Positioned.fill(
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: size.height*0.05
                        ),
                        margin:
                        EdgeInsetsDirectional.only(end: size.width * 0.02),
                        padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.horizontal(
                              start: Radius.circular(size.height * 0.005)),
                          color: kPrimaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "+962",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.017),
                          ),
                        ),
                      )
                    ),
                  )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
