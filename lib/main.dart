import 'package:flutter/material.dart';
import 'package:online_shop/AddItem.dart';
import 'package:online_shop/Categouries.dart';
import 'package:online_shop/model_iteam.dart';
import 'connectDatabase/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> arr = ["hand bag", "T-shirt", "foodware", "dress"];
  List<String> typeCateg = [
    "getHandbag",
    "getT-shirt",
    "getHandbag",
    "getHandbag"
  ];

  int selectCategoury = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.grey[400],
              onPressed: () {},
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.grey[400],
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Colors.grey[400],
                onPressed: () {},
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: SizedBox(
                  height: 85,
                  child: ListView.separated(
                    separatorBuilder: (context, position) =>
                        SizedBox(width: 20,),
                    scrollDirection: Axis.horizontal,
                    itemCount: arr.length,
                    itemBuilder: (context, position) =>
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectCategoury = position;
                              setCategoury(typeCateg[selectCategoury]);
                            });
                          },
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: getImage(position),
                            ),
                            Text(
                              arr[position],
                              style: selectCategoury == position
                                  ? TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)
                                  : TextStyle(fontSize: 16),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: 40,
                              height: 1,
                              color: selectCategoury == position
                                  ? Colors.black
                                  : Colors.transparent,
                            )
                          ],
                        ),
                          ),
                        ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: getCategoury(),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Categouries(snapshot.data);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddItem()));
                },
              ),
            ),
      ),
    );
  }

  getImage(int position) {
    switch (position) {
      case 0:
        return AssetImage('images/bag_5.png');
        break;
      case 1:
        return AssetImage('images/polo.png');
        break;
      case 2:
        return AssetImage('images/bag_5.png');
        break;
      case 3:
        return AssetImage('images/bag_5.png');
        break;
    }
  }

  String getString;

  setCategoury(String type) {
    getString = type;
  }

  Stream<dynamic> getCategoury() async* {
    if (getString == null) {
      yield "getHandbag";
    }
    else {
      yield getString;
    }
  }
}
