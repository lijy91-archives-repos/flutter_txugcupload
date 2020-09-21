import './tx_publish_result.dart';

abstract class TXVideoPublishListener {
  void onPublishProgress(int uploadBytes, int totalBytes);
  void onPublishComplete(TXPublishResult result);
}
