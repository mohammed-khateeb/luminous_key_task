import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Api/current_user.dart';
import '../Models/Api/user.dart';


class UserUtils {
  static SharedPreferences? preferences;

  static bool firstUse = true;

  static initCurrentUser(User user) async {
    CurrentUser.token = user.id.toString();
    CurrentUser.firstName = user.firstName;

    fetchUserInformationToShared();
  }

  static updateCurrentUserName(String userName)async{
    CurrentUser.firstName = userName;
    fetchUserNameToShared();

  }

  static checkFirstTimeUseApp() async {
    preferences = await SharedPreferences.getInstance();

    if (preferences!.getBool("first_use") != null) {
      firstUse = preferences!.getBool("first_use")!;
    }
  }

  static updateFirstUse(bool value) async {
    preferences = await SharedPreferences.getInstance();

    preferences!.setBool("first_use", value);
  }

  static Future<void> fetchUserInformationToShared() async {
    preferences = await SharedPreferences.getInstance();
    if (CurrentUser.token != null) {
      preferences!.setString("token", CurrentUser.token!);
    }

    if (CurrentUser.firstName != null) {
      preferences!.setString("first_name", CurrentUser.firstName!);
    }

    if (CurrentUser.fcmToken != null) {
      preferences!.setString("fcm_token", CurrentUser.fcmToken!);
    }

    await preferences!.commit();
  }
  static Future<void> fetchUserNameToShared() async {
    preferences = await SharedPreferences.getInstance();

    if (CurrentUser.firstName != null) {
      preferences!.setString("first_name", CurrentUser.firstName!);
    }

    await preferences!.commit();
  }

  static Future<void> fetchUserInformationFromSharedToSingletonClass() async {
    preferences = await SharedPreferences.getInstance();
    String? token = preferences!.getString("token");
    String? fcmToken = preferences!.getString("fcm_token");
    String? firstName = preferences!.getString("first_name");

    CurrentUser.token = token;
    CurrentUser.fcmToken = fcmToken;
    CurrentUser.firstName = firstName;

  }



  static Future<void> signOut() async {
    SharedPreferences preferences;

    preferences = await SharedPreferences.getInstance();

    await preferences.clear();

    CurrentUser.token = null;
    CurrentUser.firstName = null;
    CurrentUser.fcmToken = null;
  }
}
