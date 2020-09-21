import 'dart:async';

import 'package:flutter/services.dart';

export './src/tx_media_publish_listener.dart';
export './src/tx_media_publish_param.dart';
export './src/tx_publish_result.dart';
export './src/tx_publish_param.dart';
export './src/tx_publish_result.dart';
export './src/tx_ugc_publish.dart';
export './src/tx_video_publish_listener.dart';

class FlutterTxugcupload {
  static const MethodChannel _channel =
      const MethodChannel('flutter_txugcupload');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
