import 'package:flutter/material.dart';
import 'package:online_shop/Detial/DetialItem.dart';
import 'package:online_shop/ItemCard.dart';
import 'package:online_shop/Utility.dart';
import 'package:online_shop/connectDatabase/http.dart';
import 'package:online_shop/model_iteam.dart';

class Categouries extends StatefulWidget {

  @override
  _CategouriesState createState() => _CategouriesState();
}

class _CategouriesState extends State<Categouries> {

  List<ModelItem> list = [];
  Future refresh() async {
      list.clear();
      List<ModelItem> list2 = await Http().getData("getHandbag");
      setState(() {
        list = list2;
      });
  }
  Future<List<ModelItem>> getdata() async {
    await Future.delayed(Duration(seconds: 1));
    return list;
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
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: getdata(),
          builder: (context , snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              return GridView.builder(
                  itemCount: list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75
                  ),
                  itemBuilder: (context, position) => GestureDetector(
                    child: itemCard(position , list),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetialItem(list[position]),));
                    },
                  )
              );
            }
            else{
              return CircularProgressIndicator();
            }
          }
        ),
      ),
    );
  }

}

