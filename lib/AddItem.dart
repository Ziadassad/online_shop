import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shop/Utility.dart';
import 'package:online_shop/connectDatabase/http.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  String name , price , description;
  var nameText = TextEditingController();
  var priceText = TextEditingController();
  var descText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add item"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameText,
                decoration: InputDecoration(
                  hintText: 'name'
                ),
                onChanged: (String value){
                  name = value;
                },
              ),
              TextField(
                controller: priceText,
                decoration: InputDecoration(
                    hintText: 'price'
                ),
                onChanged: (String value){
                  price = value;
                },
              ),
              TextField(
                controller: descText,
                decoration: InputDecoration(
                    hintText: 'description'
                ),
                onChanged: (String value){
                  description = value;
                },
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16)
                ),
                width: 150,
                height: 150,
                child: FlatButton(
                  child: isImage(),
                  onPressed: (){
                    ShowDialig(context);
                  },
                ),
              ),

              Container(
                width: 200,
                margin: EdgeInsets.only(top: 200),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: FlatButton(
                  child: Text("Save"),
                  onPressed: (){
                    postData();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Map map;
  postData()async{
    try{
      map = {'name' : name,
             'price' : price,
             'image' : imageString,
        'description' : description
    };
      nameText.text = "";
      priceText.text = "";
      descText.text = "";
    }
    catch(err){
      print("Error");
    }
    Http().postData("postData" , map );
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
