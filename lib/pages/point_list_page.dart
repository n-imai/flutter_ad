import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ad/main.dart';
import 'package:flutter_ad/model/admob.dart';
import 'package:flutter_ad/model/contents.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PointListPage extends StatefulWidget {
  const PointListPage({super.key});

  @override
  State<PointListPage> createState() => _PointListPageState();
}

class _PointListPageState extends State<PointListPage> {
  List<BannerAd> bannerAds = [];
  late InterstitialAd interstitialAd;
  int tapCount = 0;
  bool isLoaded = false;
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

  void initAd(){
    for(int i = 0; i < contentsList.length ~/ 4; i++){
      BannerAd bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: Platform.isAndroid ? Admob.getAdId(deviceType: 'android', adType: 'banner') : Admob.getAdId(deviceType: 'ios', adType: 'banner'),
          request: AdRequest(),
          listener: BannerAdListener(
            onAdLoaded: (Ad ad){
              setState(() {
                isLoaded = true;
              });
            }
          ),
      )..load();
      bannerAds.add(bannerAd);
    }
    InterstitialAd.load(
        adUnitId: Platform.isAndroid ? Admob.getAdId(deviceType: 'android', adType: 'interstitial') : Admob.getAdId(deviceType: 'ios', adType: 'interstitial'),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('インタースティシャル広告の読み込みに失敗: $error');
          },
        ),
    );
  }



  @override
  void initState() {
    super.initState();
    initAd();
  }

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
      body:SingleChildScrollView(child: Column(
        children: [
          isMultiply ? Container(
            width: 300,
            height: 50,
            color: Colors.amber,
            alignment: Alignment.center,
            child: Text('ポイント倍増中', style: TextStyle(fontSize: 20, color: Colors.white), ),
          ) : Container(

          ),
          buildList(),
        ],
      )),
    );
  }

  Widget buildList(){
    List<Widget> rowChildren = [];
    List<Widget> columnChildren = [];

    for(int i =0; i < contentsList.length; i++){
      rowChildren.add(
        Expanded(
            child: InkWell(
              onTap: () async{
                setState(() {
                  if(isMultiply == true) {
                    totalPoint = totalPoint + contentsList[i].point * 2;
                  } else {
                    totalPoint = totalPoint + contentsList[i].point;
                  }
                });
                if (tapCount < 2){
                  tapCount = tapCount + 1;
                } else {
                  await interstitialAd.show();
                  InterstitialAd.load(
                    adUnitId: Platform.isAndroid ? Admob.getAdId(deviceType: 'android', adType: 'interstitial') : Admob.getAdId(deviceType: 'ios', adType: 'interstitial'),
                    request: AdRequest(),
                    adLoadCallback: InterstitialAdLoadCallback(
                      onAdLoaded: (InterstitialAd ad) {
                        interstitialAd = ad;
                      },
                      onAdFailedToLoad: (LoadAdError error) {
                        print('インタースティシャル広告の読み込みに失敗: $error');
                      },
                    ),
                  );
                  tapCount = 0;
                }
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
            width: bannerAds[i ~/ 4].size.width.toDouble(),
            height: bannerAds[i ~/ 4].size.height.toDouble(),
            child: isLoaded ? AdWidget(ad: bannerAds[i ~/ 4],) : Container(),
          )
        );
      }
    }
    return Column(
      children: columnChildren,
    );
  }
}
