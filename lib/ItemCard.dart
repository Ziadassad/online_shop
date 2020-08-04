import 'package:flutter/material.dart';
import 'package:online_shop/Utility.dart';
import 'file:///Z:/FlutterApp/online_shop/lib/Model/model_iteam.dart';

class itemCard extends StatelessWidget {
  int position;
  List<ModelItem> list;
  itemCard(this.position , this.list);
  @override
  Widget build(BuildContext context) {
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
           child: Utility.imageFromBase64String(list[position].image),
        ),
        Text(list[position].name, style: TextStyle(color: Colors.grey),),
        SizedBox(height: 5,),
        Text("${list[position].price} \$")
      ],
    );
  }
}