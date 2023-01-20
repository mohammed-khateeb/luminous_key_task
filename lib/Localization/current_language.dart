import 'package:shared_preferences/shared_preferences.dart';
import 'language_constants.dart';

bool currentLanguageIsEnglish = true;

void checkCurrentLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LAGUAGE_CODE) ?? "en";
  if (languageCode == 'en') {
    currentLanguageIsEnglish = true;
  } else {
    currentLanguageIsEnglish = false;
  }
}
