import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_shop/model_iteam.dart';

class Http {
  List<ModelItem> listItem = [];

  Future postData(String route ,[dynamic data])async{
    String url = "http://192.168.100.3:3000/${route}";
    var dataStr = jsonEncode(data);
    var result = await http.post(url , body: dataStr ,headers: {"Content-Type":"application/json"});
    print(jsonDecode(result.body)['status']);
    return jsonDecode(result.body)['status'].toString();
  }

  Future<List<ModelItem>> getData(String route) async {
    listItem.clear();
    String url = "http://192.168.100.3:3000/${route}";
    var result = await http.get(url);
    var list = jsonDecode(result.body) as List<dynamic>;
   // print(list[0]["name"]);
   list.forEach((element) {
    // print(element['id']);
     listItem.add(
         ModelItem(
             element['id'],
             element['name'],
             element['price'],
             element['image'].toString(),
             element['description']
         )
     );
   });
  // print(listItem.length);
   return listItem;
  }
}
