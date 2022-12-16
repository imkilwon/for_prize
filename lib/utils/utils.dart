import 'package:shared_preferences/shared_preferences.dart';

class Utils{
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
      return storage.setStringList(title, data);

  }
  readStringListData(String title)async{
    var storage = await SharedPreferences.getInstance();
    print("!");
    var result = storage.getStringList(title);
    print("!");
    print(result);
  }
}