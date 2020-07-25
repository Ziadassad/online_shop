import 'package:flutter/material.dart';
import 'package:online_shop/Utility.dart';
import 'package:online_shop/model_iteam.dart';

class DetialItem extends StatefulWidget {
  ModelItem _item;
  DetialItem(this._item);
  @override
  _DetialItemState createState() => _DetialItemState();
}

class _DetialItemState extends State<DetialItem> {
  ModelItem modelItem;
  String color;
  int numOfItem = 1;
  @override
  Widget build(BuildContext context) {
    modelItem = widget._item;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          color: Colors.grey[400] ,
          onPressed: (){Navigator.pop(context);},
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),color: Colors.grey[400] , onPressed: (){},),
          IconButton(icon: Icon(Icons.shopping_cart),color: Colors.grey[400] , onPressed: (){},)
        ],
      ),

     body: Container(
       height: double.infinity,
       width: double.infinity,
       color: Colors.cyan[600],
       child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.4),
                    decoration:   BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)
                      ),
                      color: Colors.white,
                    ),
                    height: 500,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Gatergoury handbag"),
                        SizedBox(height: 8,),
                        Text(modelItem.name,style: TextStyle(fontSize: 30),),
                        Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "Price\n"),
                                  TextSpan(text: "\$${modelItem.price}" , style: TextStyle(fontSize: 30)),
                                ]
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(child: Image.memory(Utility.dataFromBase64String(modelItem.image)))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Color"),
                            Row(
                              children: <Widget>[
                               Expanded(
                                 child: Row(
                                   children: <Widget>[
                                     Container(
                                       margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
                                       padding: EdgeInsets.all(2.5),
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           border: Border.all(color: Colors.blue)
                                       ),
                                       height: 24,
                                       width: 24,
                                       child: DecoratedBox(
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               color: Colors.blue
                                           )
                                       ),
                                     ),
                                     Container(
                                       margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
                                       padding: EdgeInsets.all(2.5),
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           border: Border.all(color: Colors.yellow)
                                       ),
                                       height: 24,
                                       width: 24,
                                       child: DecoratedBox(
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               color: Colors.yellow
                                           )
                                       ),
                                     ),
                                     Container(
                                       margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
                                       padding: EdgeInsets.all(2.5),
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           border: Border.all(color: Colors.black)
                                       ),
                                       height: 24,
                                       width: 24,
                                       child: DecoratedBox(
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               color: Colors.black
                                           )
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                               Expanded(
                                 child: RichText(
                                   text: TextSpan(
                                     style: TextStyle(color: Colors.black45),
                                     children: [
                                       TextSpan(text: "Size\n"),
                                       TextSpan(text: "12cm" , style: TextStyle(fontSize: 30))
                                     ]
                                   ),
                                 ),
                               )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      Text(modelItem.description , style: TextStyle(height: 1.5),),
                       Padding(
                         padding: EdgeInsets.only(top: 40),
                         child: Row(
                           children: <Widget>[
                            numberItem((){setState(() {if(numOfItem > 1)numOfItem--;});}, Icon(Icons.remove)),
                             SizedBox(width: 10,),
                             Text("${numOfItem}" , style: TextStyle(fontSize: 20),),
                             SizedBox(width: 10,),
                             numberItem((){setState(() {numOfItem++;});}, Icon(Icons.add))
                           ],
                         ),
                       )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
    ),
     ),
    );
  }
  numberItem(Function function , Icon icon){
    return Container(
      height: 30,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: Colors.black
        ),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: function,
        child: icon,
      ),
    );
  }
}
