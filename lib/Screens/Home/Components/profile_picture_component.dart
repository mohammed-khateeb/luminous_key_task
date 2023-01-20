import 'package:flutter/material.dart';

class ProfilePictureComponent extends StatelessWidget {
  const ProfilePictureComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      left: 0,
      right: 0,
      child: Container(
        height: size.height*0.12,
        width: size.height*0.12,
        padding: EdgeInsets.all(size.height*0.01),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
        ),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/profile_picture.jpg",
                  )
              )
          ),

        ),
      ),
    );
  }
}
