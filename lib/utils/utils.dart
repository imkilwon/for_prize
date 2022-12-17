import 'package:shared_preferences/shared_preferences.dart';

class Utils{

   static SharedPreferences? _preferences;

   static Future init()async{
     _preferences = await SharedPreferences.getInstance();
   }

  saveIntData(String title, int data)async{
    var storage = await SharedPreferences.getInstance();
      return storage.setInt(title, data);
  }
  saveStringData(String title, String data)async{
    var storage = await SharedPreferences.getInstance();
      return storage.setString(title, data);
  }
  saveStringListData(String title, List<String> data)async{
    var storage = await SharedPreferences.getInstance();
      await _preferences?.setStringList(title, data);
  }
  List<int> readStringListData(String title){

    // var storage = await SharedPreferences.getInstance();
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