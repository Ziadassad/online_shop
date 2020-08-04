import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/AddItem.dart';
import 'package:online_shop/Categouries.dart';
import 'package:online_shop/DataProvider.dart';
import 'package:online_shop/Setting.dart';
import 'package:online_shop/Siginin.dart';
import 'package:online_shop/Utility.dart';
import 'file:///Z:/FlutterApp/online_shop/lib/Model/model_iteam.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'connectDatabase/http.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';

void main() {
  runApp(ChangeNotifierProvider<DataChanger>(
      create: (_) => DataChanger("", ThemeData.light()), child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  SharedPreferences sharedPreferences;
  String name;

  String email;
  String image;
  List<String> arr = ["hand bag", "T-shirt", "shoes", "dress"];
  List<String> typeCateg = [
    "getHandbag",
    "getT-shirt",
    "getHandbag",
    "getHandbag"
  ];

  bool isLogin = false;
  int selectCategoury = 0;
  var textSearch = TextEditingController();

  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    load();
    super.initState();
  }

  load() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isLogin = sharedPreferences.getBool("isLogin") ?? false;
    List<String> account = sharedPreferences.getStringList("account") ?? ["no"];
    if (account[0] == "no") {
      print("account");
    } else {
      name = account[0];
      email = account[1];
      image = account[2];
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataChanger>(context);
    return ConnectivityAppWrapper(
      app: MaterialApp(
        theme: data.getTheme(),
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (BuildContext context) =>
              Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(45),
                  child: StatefulBuilder(
                    builder: (context, state) =>
                        AppBar(
                          backgroundColor: Colors.cyan,
                          elevation: 0,
                          title: isSearch ? TextField(
                            controller: textSearch,
                            decoration: InputDecoration(
                                hintText: 'searching...'
                            ),
                            onChanged: (string) {
                              data.setList(string);
                            },
                          ) : Text("online shop"),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.search),
                              color: Colors.grey[400],
                              onPressed: () {
                                state(() {
                                  isSearch = !isSearch;
                                  if (isSearch) {
                                    textSearch.text = data.getList();
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.shopping_cart),
                              color: Colors.grey[400],
                              onPressed: () {},
                            )
                          ],
                        ),
                  ),
                ),
                body: ConnectivityWidgetWrapper(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    gradient: new LinearGradient(
                      colors: [Colors.red, Colors.cyan],
                    ),
                  ),
                  message: 'you are offline',
                  child: Column(
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)
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
                          if (snapshot.connectionState ==
                              ConnectionState.done &&
                              snapshot.hasData) {
                            return Categouries(snapshot.data);
                          }
                          else if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return Center(
                              child: Text("no data has available"),);
                          }
                          else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      )
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddItem()));
                  },
                ),
                drawer: Drawer(

                  child: ListView(
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: isLogin ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.cyan,
                                child: Image.memory(
                                    Utility.dataFromBase64String(image))
                            ),
                            Text(name),
                            Text(email)
                          ],
                        ) : Center(
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Signin()));
                            },
                            child: Text("Signin"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => Setting()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.settings),
                          title: Text("setting", style: TextStyle(fontSize: 20,
                              fontStyle: FontStyle.italic),),
                        ),
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: ListTile(
                          leading: Icon(Icons.help),
                          title: Text("about", style: TextStyle(fontSize: 20,
                              fontStyle: FontStyle.italic),),
                        ),
                      ),
                    ],
                  ),
                ),
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
        return AssetImage('images/shoes.png');
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
