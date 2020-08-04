import 'dart:convert';
import 'package:http/http.dart' as http;
import 'file:///Z:/FlutterApp/online_shop/lib/Model/model_iteam.dart';
import 'package:online_shop/Model/Account.dart';

class Http {
  List<ModelItem> listItem = [];

  Future postAccount(Map<String, dynamic> map) async {
    String url = "http://192.168.100.3:3000/postaccount";
    var data = jsonEncode(map);
    var result = await http
        .post(url, body: data, headers: {"Content-Type": "application/json"});
    print(jsonDecode(result.body)['status']);
  }

  List<Account> accounts = [];

  Future getAccount() async {
    String url = "http://192.168.100.3:3000/getaccount";
    var result = await http.get(url);
    // print(jsonDecode(result.body));
    var data = jsonDecode(result.body) as List<dynamic>;

    data.forEach((element) {
      accounts.add(Account(element['id'], element['name'], element["email"],
          element['password'], element['image']));
    });
    return accounts;
  }

  Future postData(String route, [dynamic data]) async {
    String url = "http://192.168.100.3:3000/${route}";
    var dataStr = jsonEncode(data);
    var result = await http.post(url,
        body: dataStr, headers: {"Content-Type": "application/json"});
    print(jsonDecode(result.body)['status']);
    return jsonDecode(result.body)['status'].toString();
  }

  Future<List<ModelItem>> getData(String route) async {
    listItem.clear();
    String url = "http://192.168.100.3:3000/${route}";
    var result = await http.get(url);
    var list = jsonDecode(result.body) as List<dynamic>;
   list.forEach((element) {
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
