import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {

 static late SharedPreferences sharedPreference;

 static  Future<SharedPreferences>  init() async
 {
  return sharedPreference= await SharedPreferences.getInstance() ;
 }

 static Future<bool> setData(String key,bool value) async
  {
   return await sharedPreference.setBool( key, value);
  }

  static bool? getData(String key)
  {
    return  sharedPreference.getBool(key);
  }

}