import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:prayer_app/resources/config.dart';

class FirebaseAdmobUtils {
  static final FirebaseAdmobUtils _firebaseAdmob =
      FirebaseAdmobUtils._internal();
  BannerAd _screenBannerAd;
  bool _loaded;
  bool _initialLoadingFinished;
  bool _closed;
  factory FirebaseAdmobUtils() {
    return _firebaseAdmob;
  }

  FirebaseAdmobUtils._internal() {
    if (Platform.isIOS) return;
    String _appId = Platform.isAndroid ? androidAppId : iosId;
    FirebaseAdMob.instance.initialize(appId: _appId);
    _loaded = false;
    _initialLoadingFinished = false;
    _closed = false;
  }

  void initScreenBanner() {

    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['PrayingApp', 'ScreenBanner'],
      childDirected: false,
      testDevices: <String>[], // Android emulators are considered test devices
    );

    String _bannerId = Platform.isAndroid ? androidBannerId : iosBannerId;

    _screenBannerAd = BannerAd(
      //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      adUnitId: _bannerId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
        if (event == MobileAdEvent.loaded || event == MobileAdEvent.failedToLoad) {
          _loaded = true;
          _initialLoadingFinished = true;
        }
        if(event == MobileAdEvent.closed){
         _closed = true;
        }
      },
    );
    _screenBannerAd.load();
  }

  loadScreenBanner() {
    if (Platform.isIOS || _closed) return;
    if (!_loaded) {
      _screenBannerAd.show(anchorOffset: 10.0, anchorType: AnchorType.bottom);
    }
  }

  disposeScreenBanner() {
    if (Platform.isIOS || _closed) return;
    if (_loaded) {
      _screenBannerAd.dispose();
      _loaded = false;
    } else {
      if (_initialLoadingFinished) throw Exception;
    }
  }
}
