import 'package:flutter/material.dart';
import 'package:online_shop/Detial/DetialItem.dart';
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
    print("hi");
      list.clear();
      List<ModelItem> list2 = await Http().getData("get");
      print(list.length);
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
           return GridView.builder(
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75
                ),
                itemBuilder: (context, position) =>
                    GestureDetector(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20),
                            height: 180,
                            width: 160,
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Image.memory(
                                Utility.dataFromBase64String(list[position]
                                    .image)),
                          ),
                          Text(snapshot.data[position].name,
                            style: TextStyle(color: Colors.grey),),
                          SizedBox(height: 5,),
                          Text("${snapshot.data[position].price} \$")
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DetialItem(list[position]),));
                      },
                    )
            );
          }
        ),
      ),
    );
  }

}

class ItemCard extends StatelessWidget {
  int position;
  List<ModelItem> list;
  ItemCard(this.position , this.list);
  @override
  Widget build(BuildContext context) {
    print(position);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          height: 180,
          width: 160,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(15)
          ),
         // child: Utility.imageFromBase64String(list[position].image),
        ),
        Text(list[position].name, style: TextStyle(color: Colors.grey),),
        SizedBox(height: 5,),
        Text("${list[position].price} \$")
      ],
    );
  }
}
