import 'package:shared_preferences/shared_preferences.dart';

///Generic [Async Storage] Service class for managing the async storge
class SharedPreferenceServiceClass {
  SharedPreferences _sharedPreferences;

  //This addStringInSF function for saving string in async storage=>"Shared Preference"
  addStringInSF(String key, String value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(key, value);
  }

  //This getStringInSF function for getting string from async storage=>"Shared Preference"
  Future<String> getStringInSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key);
    return stringValue;
  }

  //This removeValueFromSF function for deleting value from async storage=>"Shared Preference"
  Future<bool> removeValueFromSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool stringValue = await prefs.remove(key);
    return stringValue;
  }
}
