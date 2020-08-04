import 'package:flutter/material.dart';
import 'package:online_shop/DataProvider.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool checkDark = false;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataChanger>(context);
    if (data.getTheme() == ThemeData.dark()) {
      checkDark = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("Dark Mode"),
            trailing: Switch(
              value: checkDark,
              onChanged: (check) {
                setState(() {
                  if (check) {
                    data.setTheme(ThemeData.dark());
                    checkDark = check;
                  } else {
                    data.setTheme(ThemeData.light());
                    checkDark = check;
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
