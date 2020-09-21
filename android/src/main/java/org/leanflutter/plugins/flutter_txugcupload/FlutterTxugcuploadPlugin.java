package org.leanflutter.plugins.flutter_txugcupload;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;

import com.tencent.ugcupload.demo.videoupload.TXUGCPublish;
import com.tencent.ugcupload.demo.videoupload.TXUGCPublishTypeDef;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static org.leanflutter.plugins.flutter_txugcupload.Constants.CHANNEL_NAME;
import static org.leanflutter.plugins.flutter_txugcupload.Constants.EVENT_CHANNEL_NAME;

/**
 * FlutterTxugcuploadPlugin
 */
public class FlutterTxugcuploadPlugin implements FlutterPlugin, StreamHandler, MethodCallHandler, TXUGCPublishTypeDef.ITXVideoPublishListener, TXUGCPublishTypeDef.ITXMediaPublishListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel methodChannel;
    private EventChannel eventChannel;
    private EventChannel.EventSink eventSink;

    private Context activeContext;
    private Handler platformThreadHandler = new Handler(Looper.getMainLooper());

    private String customKey;
    private TXUGCPublish txUgcPublish;

    private void setupChannel(BinaryMessenger messenger, Context context) {
        this.activeContext = context;

        this.methodChannel = new MethodChannel(messenger, CHANNEL_NAME);
        this.methodChannel.setMethodCallHandler(this);
        this.eventChannel = new EventChannel(messenger, EVENT_CHANNEL_NAME);
        this.eventChannel.setStreamHandler(this);
    }

    private void teardownChannel() {
        this.methodChannel.setMethodCallHandler(null);
        this.methodChannel = null;
        this.eventChannel.setStreamHandler(null);
        this.eventChannel = null;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.setupChannel(flutterPluginBinding.getBinaryMessenger(), flutterPluginBinding.getApplicationContext());
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    public static void registerWith(Registrar registrar) {
        final FlutterTxugcuploadPlugin plugin = new FlutterTxugcuploadPlugin();
        plugin.setupChannel(registrar.messenger(), registrar.activeContext());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.teardownChannel();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("setCustomKey")) {
            setCustomKey(call, result);
        } else if (call.method.equals("publishVideo")) {
            publishVideo(call, result);
        } else if (call.method.equals("publishMedia")) {
            publishMedia(call, result);
        } else if (call.method.equals("cancelPublish")) {
            cancelPublish(call, result);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onListen(Object args, EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
    }

    @Override
    public void onCancel(Object args) {
        this.eventSink = null;
    }

    private void setCustomKey(@NonNull MethodCall call, @NonNull Result result) {
        String customKey = null;
        if (call.hasArgument("customKey")) {
            customKey = call.argument("customKey");
        }
        if (txUgcPublish == null || (customKey != null && !customKey.equals(this.customKey))) {
            txUgcPublish = new TXUGCPublish(this.activeContext, customKey);
            txUgcPublish.setListener((TXUGCPublishTypeDef.ITXVideoPublishListener) this);
            txUgcPublish.setListener((TXUGCPublishTypeDef.ITXMediaPublishListener) this);
        }
        this.customKey = customKey;
    }

    private void publishVideo(@NonNull MethodCall call, @NonNull Result result) {
        TXUGCPublishTypeDef.TXPublishParam param = new TXUGCPublishTypeDef.TXPublishParam();
        if (call.hasArgument("param")) {
            HashMap<String, Object> paramJson = call.argument("param");
            if (paramJson != null) {
                if (paramJson.containsKey("signature"))
                    param.signature = (String) paramJson.get("signature");
                if (paramJson.containsKey("videoPath"))
                    param.videoPath = ((String) paramJson.get("videoPath")).replace("file://", "");
                if (paramJson.containsKey("coverPath"))
                    param.coverPath = ((String) paramJson.get("coverPath")).replace("file://", "");
                if (paramJson.containsKey("enableResume"))
                    param.enableResume = (boolean) paramJson.get("enableResume");
                if (paramJson.containsKey("enableHttps"))
                    param.enableHttps = (boolean) paramJson.get("enableHttps");
                if (paramJson.containsKey("fileName"))
                    param.fileName = (String) paramJson.get("fileName");
            }
        }

        int ret = txUgcPublish.publishVideo(param);
        result.success(ret);
    }

    private void publishMedia(@NonNull MethodCall call, @NonNull Result result) {
        TXUGCPublishTypeDef.TXMediaPublishParam param = new TXUGCPublishTypeDef.TXMediaPublishParam();
        if (call.hasArgument("param")) {
            HashMap<String, Object> paramJson = call.argument("param");
            if (paramJson != null) {
                if (paramJson.containsKey("signature"))
                    param.signature = (String) paramJson.get("signature");
                if (paramJson.containsKey("mediaPath"))
                    param.mediaPath = ((String) paramJson.get("mediaPath")).replace("file://", "");
                if (paramJson.containsKey("enableResume"))
                    param.enableResume = (boolean) paramJson.get("enableResume");
                if (paramJson.containsKey("enableHttps"))
                    param.enableHttps = (boolean) paramJson.get("enableHttps");
                if (paramJson.containsKey("fileName"))
                    param.fileName = (String) paramJson.get("fileName");
            }
        }

        int ret = txUgcPublish.publishMedia(param);
        result.success(ret);
    }

    private void cancelPublish(@NonNull MethodCall call, @NonNull Result result) {
        txUgcPublish.canclePublish();

        result.success(true);
    }

    @Override
    public void onPublishProgress(long uploadBytes, long totalBytes) {
        final Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("uploadBytes", uploadBytes);
        dataMap.put("totalBytes", totalBytes);

        sendEvent("TXVideoPublishListener", "onPublishProgress", dataMap);
    }

    @Override
    public void onPublishComplete(TXUGCPublishTypeDef.TXPublishResult result) {
        final Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("retCode", result.retCode);
        resultMap.put("descMsg", result.descMsg);
        resultMap.put("videoId", result.videoId);
        resultMap.put("videoURL", result.videoURL);
        resultMap.put("coverURL", result.coverURL);

        final Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("result", resultMap);

        sendEvent("TXVideoPublishListener", "onPublishComplete", dataMap);
    }

    @Override
    public void onMediaPublishProgress(long uploadBytes, long totalBytes) {
        final Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("uploadBytes", uploadBytes);
        dataMap.put("totalBytes", totalBytes);

        sendEvent("TXMediaPublishListener", "onMediaPublishProgress", dataMap);
    }

    @Override
    public void onMediaPublishComplete(TXUGCPublishTypeDef.TXMediaPublishResult mediaResult) {
        final Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("retCode", mediaResult.retCode);
        resultMap.put("descMsg", mediaResult.descMsg);
        resultMap.put("mediaId", mediaResult.mediaId);
        resultMap.put("mediaURL", mediaResult.mediaURL);

        final Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("result", resultMap);

        sendEvent("TXMediaPublishListener", "onMediaPublishComplete", dataMap);
    }

    private void sendEvent(@NonNull String listener, @NonNull String method, Map<String, Object> dataMap) {
        final Map<String, Object> eventData = new HashMap<>();
        eventData.put("listener", listener);
        eventData.put("method", method);
        eventData.put("data", dataMap);

        platformThreadHandler.post(new Runnable() {
            @Override
            public void run() {
                eventSink.success(eventData);
            }
        });
    }
}
