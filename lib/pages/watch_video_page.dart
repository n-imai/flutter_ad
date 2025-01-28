import 'package:flutter/material.dart';
import 'package:flutter_ad/main.dart';

class WatchVideoPage extends StatefulWidget {
  const WatchVideoPage({super.key});

  @override
  State<WatchVideoPage> createState() => _WatchVideoPageState();
}

class _WatchVideoPageState extends State<WatchVideoPage> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('5ポイント獲得', style: TextStyle(fontSize: 20),),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      totalPoint = totalPoint +5;
                    });
                  },
                  child: Text('動画を視聴', style: TextStyle(fontSize: 20),)
              ),
            ),
            Padding(
                padding: EdgeInsets.all(50),),
            Text('新規ポイントを2倍に', style: TextStyle(fontSize: 20),),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      isMultiply = true;
                    });
                  },
                  child: Text('動画を視聴', style: TextStyle(fontSize: 20),)
              ),
            )
          ],
        ),
      ),
    );
  }
}
