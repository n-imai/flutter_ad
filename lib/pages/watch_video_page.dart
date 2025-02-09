import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ad/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../model/admob.dart';

class WatchVideoPage extends StatefulWidget {
  const WatchVideoPage({super.key});

  @override
  State<WatchVideoPage> createState() => _WatchVideoPageState();
}

class _WatchVideoPageState extends State<WatchVideoPage> {
  RewardedAd? rewardedAd;
  RewardedAd? rewordMultiply;
  bool isRewardAdLoaded = false;
  bool isMultiplyAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
    _loadMultiplyAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: Platform.isAndroid ? Admob.getAdId(deviceType: 'android', adType: 'reward') : Admob.getAdId(deviceType: 'ios', adType: 'reward'),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              setState(() {
                rewardedAd = null;
                isRewardAdLoaded = false;
              });
              _loadRewardedAd(); // 新しい広告を読み込む
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              setState(() {
                rewardedAd = null;
                isRewardAdLoaded = false;
              });
              _loadRewardedAd(); // エラー時に再読み込み
            },
          );
          setState(() {
            rewardedAd = ad;
            isRewardAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          print('Failed to load rewarded ad: ${error.message}');
          Future.delayed(const Duration(minutes: 1), _loadRewardedAd); // 1分後に再試行
        },
      ),
    );
  }

  void _loadMultiplyAd() {
    RewardedAd.load(
      adUnitId: Platform.isAndroid ? Admob.getAdId(deviceType: 'android', adType: 'reward') : Admob.getAdId(deviceType: 'ios', adType: 'reward'),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              setState(() {
                rewordMultiply = null;
                isMultiplyAdLoaded = false;
              });
              _loadMultiplyAd(); // 新しい広告を読み込む
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              setState(() {
                rewordMultiply = null;
                isMultiplyAdLoaded = false;
              });
              _loadMultiplyAd(); // エラー時に再読み込み
            },
          );
          setState(() {
            rewordMultiply = ad;
            isMultiplyAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          print('Failed to load multiply ad: ${error.message}');
          Future.delayed(const Duration(minutes: 1), _loadMultiplyAd); // 1分後に再試行
        },
      ),
    );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('5ポイント獲得', style: TextStyle(fontSize: 20),),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: () async{
                    if(isRewardAdLoaded){
                      await rewardedAd?.show(
                        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                          setState(() {
                            totalPoint = totalPoint + 5;
                          });
                        }
                      );
                    }

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
                  onPressed: () async {
                    if(isMultiplyAdLoaded){
                      await rewordMultiply?.show(
                        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                          setState(() {
                            isMultiply = true;
                          });
                        }
                      );
                    }
                  },
                  child: Text('動画を視聴', style: TextStyle(fontSize: 20),)
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    rewardedAd?.dispose();
    rewordMultiply?.dispose();
    super.dispose();
  }
}
