import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shop/Model/Account.dart';
import 'package:online_shop/Utility.dart';
import 'package:online_shop/connectDatabase/http.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name;
  String email;
  String password;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: CircleAvatar(
                radius: 60,
                child: isImage(),
              ),
              onTap: () {
                ShowDialig(context);
              },
            ),
            TextField(
              decoration:
                  InputDecoration(hintText: 'name', icon: Icon(Icons.person)),
              onChanged: (string) {
                name = string;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'email', icon: Icon(Icons.alternate_email)),
              onChanged: (string) {
                email = string;
              },
            ),
            TextField(
              decoration:
                  InputDecoration(hintText: 'password', icon: Icon(Icons.lock)),
              onChanged: (string) {
                password = string;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'confirm password', icon: Icon(Icons.lock)),
              onChanged: (string) {
                confirmPassword = string;
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.blue),
              child: FlatButton(
                child: Text("Sign Up"),
                onPressed: () {
                  if (name == "ziad") {
                    message("this account already exist");
                  } else if (password != confirmPassword) {
                    message("password incorrect");
                  } else {
                    saveAccount();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Map map;

  saveAccount() {
    map = Account(1, name, email, password, imageString).tomap();
    Http().postAccount(map);
  }

  File imageFile;
  String imageString;

  _openCamera(BuildContext context) async {
    File picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageString = Utility.base64String(picture.readAsBytesSync());
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _opnGallary(BuildContext context) async {
    File picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
      imageString = Utility.base64String(picture.readAsBytesSync());
    });
    Navigator.of(context).pop();
  }

  isImage() {
    if (imageFile == null) {
      return Icon(
        Icons.add_a_photo,
        size: 100,
      );
    } else {
      return Image.file(
        imageFile,
        width: 200,
        height: 200,
        fit: BoxFit.fitWidth,
      );
    }
  }

  Future<void> ShowDialig(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Chioce Your Image"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text("Opne Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text("Opne Gallary"),
                      onTap: () {
                        _opnGallary(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
