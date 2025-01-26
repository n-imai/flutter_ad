import 'package:flutter/material.dart';

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
              child: Text('0', style: TextStyle(fontSize: 20),),
          )
        ],
      ),
    );
  }
}
