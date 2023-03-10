import 'package:flutter/material.dart';
import 'package:luminous_key_task/Models/Api/user.dart';
import 'package:luminous_key_task/Models/Responses/httpresponse.dart';
import 'package:luminous_key_task/Services/auth_services.dart';
import 'package:luminous_key_task/Utils/extensions.dart';
import 'package:provider/provider.dart';
import '../../Controller/auth_controller.dart';
import '../../Localization/current_language.dart';
import '../../Localization/language.dart';
import '../../Localization/language_constants.dart';
import '../../Services/auth_services.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/main_utils.dart';
import '../../Utils/navigtor_utils.dart';
import '../../Widgets/custom_animation_up.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_inkwell.dart';
import '../../Widgets/custom_text_field.dart';
import '../../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {

  final _validationFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  AuthController? _authProvider;

  bool obscureText = true;

  @override
  void initState() {
    super.initState();

    _authProvider = Provider.of<AuthController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: size.height*0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInkwell(
              onTap: (){
                _changeLanguage( Language.languageList().first);
              },
              child: Text(
                "English",
                style: TextStyle(
                    fontSize: size.height*0.02
                ),
              ),
            ),
            SizedBox(width: size.width*0.02,),
            Container(
              height: size.height*0.02,
              width: 1,
              color: Colors.grey[300],
            ),
            SizedBox(width: size.width*0.02,),
            CustomInkwell(
              onTap: (){
                _changeLanguage( Language.languageList().last);

              },
              child: Text(
                "??????????????",
                style: TextStyle(
                    fontSize: size.height*0.02
                ),
              ),
            ),
          ],
        ),
      ),

      resizeToAvoidBottomInset: true,
      body: Form(
        key: _validationFormKey,
        child: SizedBox(
          height: size.height,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                child: Column(
                  children: [

                    CustomAnimationUp(
                      millisecond: 500,
                      child: Image.asset(
                        "assets/images/logo_login.png",
                        height: size.height * 0.2,
                        cacheWidth: 1000,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomAnimationUp(
                      millisecond: 500,
                      child: CustomTextField(
                        label: getTranslated(context, "name"),
                        controller: _nameController,
                        validator: (value) {
                          if (value!.toString().trim().isEmpty) {
                            return getTranslated(context, "can_not_empty");
                          }
                          return null;
                        },                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomAnimationUp(
                      millisecond: 500,
                      child: CustomTextField(
                        label: getTranslated(context, "mobile_number"),
                        controller: _mobileController,
                        digitOnly: true,
                        textInputType: TextInputType.number,
                        maxLength: 10,
                        validator: (value) {
                          if (value!.toString().trim().isEmpty) {
                            return getTranslated(context, "can_not_empty");
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomAnimationUp(
                      millisecond: 600,
                      child: CustomTextField(
                        label: getTranslated(context, "email"),
                        controller: _emailController,
                        validator: (value) {
                          if (value!.toString().trim().isEmpty) {
                            return getTranslated(context, "can_not_empty");
                          }
                          else if (!value.toString().isValidEmail()) {
                            return getTranslated(context, "pleaseEnterAValidEmail");
                          }
                          return null;
                        },                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomAnimationUp(
                      millisecond: 850,
                      child: CustomTextField(
                        label: getTranslated(context, "password"),
                        controller: _passwordController,
                        maxLength: 255,
                        validator: (value) {
                          if (value!.toString().trim().isEmpty) {
                            return getTranslated(context, "can_not_empty");
                          }
                          else if (value.toString().trim().length < 6) {
                            return getTranslated(context, "too_short");
                          }
                          return null;
                        },
                        obscureText: obscureText,
                        suffixIcon: InkWell(
                          onTap: () {
                            obscureText = !obscureText;

                            setState(() {});
                          },
                          child: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    CustomAnimationUp(
                      millisecond: 1000,
                      child: CustomButton(
                        label: getTranslated(context, "signup")!,
                        onPressed: () {
                          onClickSignUpButton();
                          //loginTest();
                        },
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated(context, "have_account")!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size.height * 0.017,
                                  color: Colors.grey[700]),
                            ),
                            SizedBox(
                              width: size.width * 0.005,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                getTranslated(context, "login")!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: size.height * 0.017,
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  onClickSignUpButton() {
    if (checkValidFormFiled()) {
      MainUtils.showWaitingProgressDialog(forRegister: true);
      String email = _emailController.text.trim();
      String name = _nameController.text;
      String mobileNumber = _mobileController.text;

      String password = _passwordController.text.trim();
      signUp(email, password,name,mobileNumber);
    }
  }

  bool checkValidFormFiled() {
    return _validationFormKey.currentState!.validate();
  }


  void signUp(
      String email,
      String password,
      String name,
      String mobileNumber,

      ) async {
    User user = User(
      firstName: name,
      email: email,
      password: password,
        mobileNumber: mobileNumber

    );
    bool? status = await _authProvider!.signUp(user);

    MainUtils.hideWaitingProgressDialog();
    if (status) {
      NavigatorUtils.navigateToHomeScreen(MainUtils.navKey.currentContext!);
    } else {
      MainUtils.showErrorAlertDialog(getTranslated(context, "this_email_is_already_used")!);
    }
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
    if (language.languageCode == 'en') {
      currentLanguageIsEnglish = true;
    } else {
      currentLanguageIsEnglish = false;
    }

  }




}
