import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:prayer_app/resources/config.dart';

class FirebaseAdmobUtils {
  static final FirebaseAdmobUtils _firebaseAdmob =
      FirebaseAdmobUtils._internal();
  BannerAd _screenBannerAd;
  bool _loaded;
  bool _initialLoadingFinished;
  factory FirebaseAdmobUtils() {
    return _firebaseAdmob;
  }

  FirebaseAdmobUtils._internal() {
    if (Platform.isIOS) return;
    String _appId = Platform.isAndroid ? androidAppId : iosId;
    FirebaseAdMob.instance.initialize(appId: _appId);
    _loaded = false;
    _initialLoadingFinished = false;
  }

  void initScreenBanner() {
    if (Platform.isIOS) return;
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['PrayingApp', 'ScreenBanner'],
      childDirected: false,
      testDevices: <String>[], // Android emulators are considered test devices
    );

    _screenBannerAd = BannerAd(
      //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      adUnitId: androidBannerId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
        if (event == MobileAdEvent.loaded) {
          _loaded = true;
          _initialLoadingFinished = true;
        }
      },
    );
    _screenBannerAd.load();
  }

  loadScreenBanner() {
    if (Platform.isIOS) return;
    if (!_loaded) {
      _screenBannerAd.show(anchorOffset: 10.0, anchorType: AnchorType.bottom);
    }
  }

  disposeScreenBanner() {
    if (Platform.isIOS) return;
    if (_loaded) {
      _screenBannerAd.dispose();
      _loaded = false;
    } else {
      if (_initialLoadingFinished) throw Exception;
    }
  }
}
