import 'package:flutter/material.dart';

import '../../../Localization/language_constants.dart';
import '../../../Utils/color_utils.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.06,
      width: size.width*0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.height*0.015),
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
        children: [
          SizedBox(width: size.width*0.02,),
          Icon(
            Icons.search,
            size: size.height*0.032,
          ),
          SizedBox(width: size.width*0.02,),
          Expanded(
            child: TextField(
              style: TextStyle(
                  fontSize: size.height*0.02
              ),
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: getTranslated(context, "search_hint_msg"),
                  hintStyle: TextStyle(
                    fontSize: size.height*0.018,
                  )
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(size.height*0.015)),
              color: kPrimaryColor,
            ),
            width:10,
          )
        ],
      ),
    );
  }
}
