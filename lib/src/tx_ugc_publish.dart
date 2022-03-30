import 'package:flutter/services.dart';

import './tx_media_publish_listener.dart';
import './tx_media_publish_param.dart';
import './tx_media_publish_result.dart';
import './tx_publish_param.dart';
import './tx_publish_result.dart';
import './tx_video_publish_listener.dart';

const _kMethodChannelName = 'flutter_txugcupload';
const _kEventChannelName = 'flutter_txugcupload/event_channel';

class TXUGCPublish {
  final MethodChannel _methodChannel = const MethodChannel(_kMethodChannelName);
  final EventChannel _eventChannel = const EventChannel(_kEventChannelName);

  TXVideoPublishListener? _videoPublishListener;
  TXMediaPublishListener? _mediaPublishListener;

  String? customKey;

  TXUGCPublish({this.customKey}) {
    _eventChannel.receiveBroadcastStream().listen(_onEvent);
  }

  void _onEvent(dynamic event) {
    String listener = '${event['listener']}';
    String method = '${event['method']}';
    dynamic data = event['data'];

    switch (listener) {
      case 'TXVideoPublishListener':
        _handleVideoPublishOnEvent(method, data);
        break;
      case 'TXMediaPublishListener':
        _handleMediaPublishOnEvent(method, data);
        break;
    }
  }

  void _handleVideoPublishOnEvent(String method, dynamic data) {
    if (_videoPublishListener == null) return;

    switch (method) {
      case 'onPublishProgress':
        _videoPublishListener?.onPublishProgress(
          data['uploadBytes'],
          data['totalBytes'],
        );
        break;
      case 'onPublishComplete':
        var resultJson = Map<String, dynamic>.from(data['result']);
        _videoPublishListener?.onPublishComplete(
          TXPublishResult.fromJson(resultJson),
        );
        break;
    }
  }

  void _handleMediaPublishOnEvent(String method, dynamic data) {
    if (_mediaPublishListener == null) return;

    switch (method) {
      case 'onMediaPublishProgress':
        _mediaPublishListener?.onMediaPublishProgress(
          data['uploadBytes'],
          data['totalBytes'],
        );
        break;
      case 'onMediaPublishComplete':
        var mediaResultJson = Map<String, dynamic>.from(data['mediaResult']);
        _mediaPublishListener?.onMediaPublishComplete(
          TXMediaPublishResult.fromJson(mediaResultJson),
        );
        break;
    }
  }

  void setMediaPublishListener(TXMediaPublishListener listener) {
    _mediaPublishListener = listener;
  }

  void setVideoPublishListener(TXVideoPublishListener listener) {
    _videoPublishListener = listener;
  }

  /// 上传视频文件 （视频文件 + 封面图）
  Future<int> publishVideo(TXPublishParam param) async {
    _methodChannel.invokeMethod('setCustomKey', {'customKey': customKey});
    dynamic arguments = {
      'param': param.toJson(),
    };
    return await _methodChannel.invokeMethod('publishVideo', arguments);
  }

  /// 上传媒体文件
  Future<int> publishMedia(TXMediaPublishParam param) async {
    _methodChannel.invokeMethod('setCustomKey', {'customKey': customKey});
    dynamic arguments = {
      'param': param.toJson(),
    };
    return await _methodChannel.invokeMethod('publishMedia', arguments);
  }

  /// 取消上传 （取消媒体/取消短视频发布）
  /// 注意：取消的是未开始的分片。如果上传源文件太小，取消的时候已经没有分片还未触发上传，最终文件还是会上传完成
  void canclePublish() async {
    await _methodChannel.invokeMethod('canclePublish');
  }
}
