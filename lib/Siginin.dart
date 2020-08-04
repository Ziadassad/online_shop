import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_shop/DataProvider.dart';
import 'package:online_shop/Model/Account.dart';
import 'package:online_shop/SingUp.dart';
import 'package:online_shop/connectDatabase/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  SharedPreferences sharedPreferences;
  String name;
  String password;
  List<String> list;
  List<Account> account;

  @override
  void initState() {
    // TODO: implement initState
    getAccount();
    super.initState();
  }

  getAccount() async {
    account = await Http().getAccount();
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataChanger>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "SignIn",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 150),
        child: Column(
          children: <Widget>[
            TextField(
              decoration:
                  InputDecoration(hintText: 'name', icon: Icon(Icons.person)),
              onChanged: (string) {
                setState(() {
                  name = string;
                });
              },
            ),
            TextField(
              decoration:
                  InputDecoration(hintText: 'password', icon: Icon(Icons.lock)),
              onChanged: (string) {
                password = string;
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.blue),
              child: FlatButton(
                child: Text("log in"),
                onPressed: () {
                  for (int i = 0; i < account.length; i++) {
                    if (name == account[i].name) {
                      if (password == account[i].password) {
                        sharedPreferences.setBool("isLogin", true);
                        list = [name, account[i].email, account[i].image];
                        sharedPreferences.setStringList("account", list);
                        Navigator.pop(context);
                      } else {
                        message("password incorrect");
                      }
                    } else {
                      message("this account not exist");
                    }
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: FlatButton(
                child: Text("Sign Up"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void message(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
