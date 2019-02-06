import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:prayer_app/resources/config.dart';

class FirebaseAdmobUtils {
  static final FirebaseAdmobUtils _firebaseAdmob = FirebaseAdmobUtils._internal();

  factory FirebaseAdmobUtils() {
    return _firebaseAdmob;
  }

  FirebaseAdmobUtils._internal() {
    String _appId = Platform.isAndroid ? androidAppId : '';
    FirebaseAdMob.instance
        .initialize(appId: _appId);
  }

  BannerAd homeScreenBanner() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['PrayingApp', 'HomeScreenBanner'],
      childDirected: false,
      testDevices: <String>[], // Android emulators are considered test devices
    );

    BannerAd myBanner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: 'ca-app-pub-9634352911405361/9366381029',
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    return myBanner;
  }
}
