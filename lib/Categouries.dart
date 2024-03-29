import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/DataProvider.dart';
import 'package:online_shop/Detial/DetialItem.dart';
import 'package:online_shop/ItemCard.dart';
import 'package:online_shop/Utility.dart';
import 'package:online_shop/connectDatabase/http.dart';
import 'file:///Z:/FlutterApp/online_shop/lib/Model/model_iteam.dart';
import 'package:provider/provider.dart';

class Categouries extends StatefulWidget {
  String _type;

  Categouries(this._type);

  @override
  _CategouriesState createState() => _CategouriesState();
}

class _CategouriesState extends State<Categouries> {

  String filter;
  List<ModelItem> list = [];
  List<ModelItem> filterList;

  Future refresh() async {
    String type = widget._type;

    list.clear();
    List<ModelItem> list2 = await Http().getData(type);
    setState(() {
      list = list2;
    });
  }

  Future<List<ModelItem>> getdata() async {
    await Future.delayed(Duration(seconds: 1));
    filterList = list
        .where((element) => (element.name.toLowerCase().contains(filter)))
        .toList();
    return filterList;
  }

  @override
  void initState() {
    // TODO: implement initState
    refresh();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataChanger>(context);
    filter = data.getList();
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                    itemCount: filterList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75
                    ),
                    itemBuilder: (context, position) =>
                        GestureDetector(
                          child: itemCard(position, list),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  DetialItem(list[position]),));
                          },
                        )
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            }
        ),
      ),
    );
  }

}

