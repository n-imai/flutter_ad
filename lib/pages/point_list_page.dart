import 'package:flutter/material.dart';
import 'package:flutter_ad/main.dart';
import 'package:flutter_ad/model/contents.dart';

class PointListPage extends StatefulWidget {
  const PointListPage({super.key});

  @override
  State<PointListPage> createState() => _PointListPageState();
}

class _PointListPageState extends State<PointListPage> {
  List<Contents> contentsList = [
    Contents(title: 'ポイント獲得', imagePath: 'assets/logo.png', point: 1),
    Contents(title: 'ポイントゲット', imagePath: 'assets/logo.png', point: 2),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
    Contents(title: 'お得です', imagePath: 'assets/logo.png', point: 3),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('ポイ活アプリ'),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 20),
            child: Text('$totalPoint', style: TextStyle(fontSize: 20),),
          )
        ],
      ),
      body:SingleChildScrollView(child: buildList()),
    );
  }

  Widget buildList(){
    List<Widget> rowChildren = [];
    List<Widget> columnChildren = [];

    for(int i =0; i < contentsList.length; i++){
      rowChildren.add(
        Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  totalPoint = totalPoint + contentsList[i].point;
                });
              },
              child: Card(
                child: Column(
                  children: [
                    Image.asset(contentsList[i].imagePath),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(contentsList[i].title),
                          Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber
                            ),
                            child: Text('${contentsList[i].point}'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        )
      );

      if(i % 2 == 1){
        columnChildren.add(Row(children: rowChildren,));
        rowChildren = [];
      } else if (i == contentsList.length - 1){
        rowChildren.add(Expanded(child: Container()));
        columnChildren.add(Row(children: rowChildren,));
        rowChildren = [];
      }
      if(i % 4 == 3){
        columnChildren.add(
          Container(
            width: 200,
            height: 100,
            color: Colors.red,
          )
        );
      }
    }
    return Column(
      children: columnChildren,
    );
  }
}
