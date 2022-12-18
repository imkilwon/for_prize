import 'package:shared_preferences/shared_preferences.dart';

class Utils{

   static SharedPreferences? _preferences;

   static Future init()async{
     _preferences = await SharedPreferences.getInstance();
   }

  saveIntData(String title, int data)async{
      return _preferences?.setInt(title, data);
  }
  saveStringData(String title, String data)async{
      return _preferences?.setString(title, data);
  }
  saveStringListData(String title, List<String> data)async{
      await _preferences?.setStringList(title, data);
  }
  List<int> readStringListData(String title){
    List<String>? tmp = _preferences?.getStringList(title);
    print(tmp);
    if (tmp == null){
      return [];
    }else{
      List<int> result = tmp.map(int.parse).toList();
      return result;
    }
  }
}