import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shop/Utility.dart';
import 'package:online_shop/connectDatabase/http.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  List<String> Categouries = ["Handbag", "T-shirt"];
  String select;

  String name, price, description;
  var nameText = TextEditingController();
  var priceText = TextEditingController();
  var descText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add item"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameText,
                  decoration: InputDecoration(hintText: 'name'),
                  onChanged: (String value) {
                    name = value;
                  },
                ),
                TextField(
                  controller: priceText,
                  decoration: InputDecoration(hintText: 'price'),
                  onChanged: (String value) {
                    price = value;
                  },
                ),
                TextField(
                  controller: descText,
                  decoration: InputDecoration(hintText: 'description'),
                  onChanged: (String value) {
                    description = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16)),
                  width: 150,
                  height: 150,
                  child: FlatButton(
                    child: isImage(),
                    onPressed: () {
                      ShowDialig(context);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState2) {
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text("SELECT Categouries"),
                              value: select,
                              onChanged: (dropdownValueSelected) {
                                setState2(() {
                                  select = dropdownValueSelected;
                                });
                              },
                              items: Categouries.map((String location) {
                                return new DropdownMenuItem<String>(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ]);
                  }),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16)),
                  child: FlatButton(
                    child: Text("Save"),
                    onPressed: () {
                      postData();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map map;

  postData()async {
    if (select == null) {
      message("you must be select one Categouries");
      return;
    }

    try {
      map = {'name': name,
        'price': price,
        'image': imageString,
        'description': description
      };
      nameText.text = "";
      priceText.text = "";
      descText.text = "";
      setState(() {
        imageFile = null;
      });
    }
    catch (err) {
      print("Error");
    }
    Http().postData("post${select}", map);
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

}
