import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:luminous_key_task/Controller/doctor_controller.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Controller/auth_controller.dart';
import 'Localization/current_language.dart';
import 'Localization/demo_localization.dart';
import 'Localization/language_constants.dart';
import 'Localization/router/custom_router.dart';
import 'Localization/router/route_constants.dart';
import 'Services/auth_services.dart';
import 'Utils/main_utils.dart';
import 'Utils/user_utils.dart';
import 'package:path/path.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    checkCurrentLanguage();

    super.initState();

    UserUtils.checkFirstTimeUseApp();
  }

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container();
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthController>(
            create: (context) => AuthController(),
          ),
          ChangeNotifierProvider<DoctorController>(
            create: (context) => DoctorController(),
          ),

        ],
        child:GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: MaterialApp(
            navigatorKey: MainUtils.navKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Regular',
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
            ),
            title: 'LuminousKey Task',
            locale: _locale,
            supportedLocales: const [
              Locale("en", "US"),
              Locale("ar", "SA"),
            ],
            localizationsDelegates: const [
              DemoLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            onGenerateRoute: CustomRouter.generatedRoute,
            initialRoute: start,
          ),
        ),
      );
    }
  }
}
