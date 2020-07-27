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
  List<String> arr = ["hand bag", "T-shirt" ,"jellewary", "foodware", "dress"];

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
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: arr.length,
                    itemBuilder: (context, position) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectCategoury = position;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                              height: 2,
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
              Categouries()
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddItem()));},
          ),
        ),
      ),
    );
  }
}
