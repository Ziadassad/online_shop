import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/Model/Account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataChanger with ChangeNotifier {
  String _list;
  ThemeData _dark;
  List<String> accounts;
  SharedPreferences sharedPreferences;

  DataChanger(this._list, this._dark);

  getList() => _list;

  getTheme() => _dark;

  setTheme(dark) {
    _dark = dark;
    notifyListeners();
  }

  setList(list) {
    _list = list;
    notifyListeners();
  }
}
