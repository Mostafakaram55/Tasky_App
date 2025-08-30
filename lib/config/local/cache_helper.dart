import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
//instance  from sharedPref
  static late SharedPreferences sharedPereferanc;

  static inti()async{
    sharedPereferanc=await SharedPreferences.getInstance();
  }

  // this method to getData from local database
  static String? getDataString ({ required String key}){
    return sharedPereferanc.getString(key);
  }
  // this method to saveData in local database

  static Future<bool>saveData ({required String key,required dynamic value})async{
    if(value is bool){
      return await sharedPereferanc.setBool(key, value);
    }else if(value is String ){
      return await sharedPereferanc.setString(key, value);
    }else if(value is int ){
      return await sharedPereferanc.setInt(key, value);
    }else{
      return await sharedPereferanc.setDouble(key, value);
    }
  }
  // this method to getData (anyData) from local database

  static dynamic getData({required String key }){
    return sharedPereferanc.get(key);
  }
  // this method to removedata (using key) from local database

  static Future<bool>remove({required String key})async{
    return await sharedPereferanc.remove(key);
  }
  // this method to  checkdata if  local database contain (Key)

  Future<bool>containsKey({required String key})async{
    return  sharedPereferanc.containsKey(key);
  }

// this method to cleara all data from local database
  Future<bool>clearData()async{
    return  sharedPereferanc.clear();
  }


}