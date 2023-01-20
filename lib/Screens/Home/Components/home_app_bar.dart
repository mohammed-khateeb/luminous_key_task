import 'package:flutter/material.dart';
import 'package:luminous_key_task/Widgets/custom_inkwell.dart';
import 'package:provider/provider.dart';

import '../../../Controller/auth_controller.dart';
import '../../../Utils/main_utils.dart';
import '../../../Utils/navigtor_utils.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
      child: Row(
        children: [
          CustomInkwell(
            onTap: (){
              signOut(context);
            },
            child: Icon(
              Icons.logout,
              size: size.height*0.03,
              color: Colors.white,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: size.height*0.03,
                      color: Colors.white,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        padding: EdgeInsets.all(size.height*0.003),
                        margin: EdgeInsets.only(top: size.height*0.005),
                        decoration: BoxDecoration(
                          color: Color(0xff00f5ff),
                          shape: BoxShape.circle,

                        ),
                        child: Text("1",style: TextStyle(
                            fontSize: size.height*0.017,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: size.width*0.035,),
              Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.notifications,
                      size: size.height*0.03,
                      color: Colors.white,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        padding: EdgeInsets.all(size.height*0.003),
                        margin: EdgeInsets.only(top: size.height*0.005),
                        decoration: BoxDecoration(
                          color: Color(0xff00f5ff),
                          shape: BoxShape.circle,

                        ),
                        child: Text("1",style: TextStyle(
                            fontSize: size.height*0.017,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  )
                ],
              ),


            ],
          )
        ],

      ),
    );
  }

  void signOut(BuildContext context) async {

    context.read<AuthController>().signOut();


    NavigatorUtils.navigateToStartScreen(context);

  }



  @override
  Size get preferredSize => const Size.fromHeight(70);
}
