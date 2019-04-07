import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:prayer_app/resources/config.dart';

class FirebaseAdmobUtils {
  static final FirebaseAdmobUtils _firebaseAdmob =
      FirebaseAdmobUtils._internal();
  BannerAd _screenBannerAd;
  bool _loaded;
  factory FirebaseAdmobUtils() {
    return _firebaseAdmob;
  }

  FirebaseAdmobUtils._internal() {
    if(Platform.isIOS) return;
    String _appId = Platform.isAndroid ? androidAppId : iosId;
    FirebaseAdMob.instance.initialize(appId: _appId);
    _loaded = false;
  }

  void initScreenBanner() {
    if(Platform.isIOS) return;
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['PrayingApp', 'ScreenBanner'],
      childDirected: false,
      testDevices: <String>[
        'D604920E53C419C308D2FB152A9AD771'
      ], // Android emulators are considered test devices
    );

    _screenBannerAd = BannerAd(
      //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      adUnitId: 'ca-app-pub-9634352911405361/9366381029',
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
        if(event == MobileAdEvent.loaded){
          _loaded = true;
        }
      },
    );
    _screenBannerAd.load();
  }

  loadScreenBanner() {
    if(Platform.isIOS) return;
    if(!_loaded){
      _screenBannerAd.show(anchorOffset: 10.0, anchorType: AnchorType.bottom);
    }
  }

  disposeScreenBanner() {
    if(Platform.isIOS) return;
    if(_loaded){
      _screenBannerAd.dispose();
      _loaded = false;
    } else {
      throw Exception;
    }
  }
}
