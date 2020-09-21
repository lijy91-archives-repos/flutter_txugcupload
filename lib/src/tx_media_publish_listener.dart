import './tx_media_publish_result.dart';

abstract class TXMediaPublishListener {
  void onMediaPublishProgress(int uploadBytes, int totalBytes);
  void onMediaPublishComplete(TXMediaPublishResult mediaResult);
}
