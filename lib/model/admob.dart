import 'admob_secret.dart';

class Admob {
  static bool isTest = true;
  static List<String> get testDevices => AdmobSecret.testDevices;
  
  static String getAdId({required String deviceType, required String adType}) {
    final adIds = isTest ? AdmobSecret.testAdIds : AdmobSecret.productionAdIds;
    final typeAds = adIds[deviceType];
    if (typeAds == null) {
      throw ArgumentError('Invalid device type: $deviceType');
    }
    final adId = typeAds[adType];
    if (adId == null) {
      throw ArgumentError('Invalid ad type: $adType');
    }
    return adId;
  }
}