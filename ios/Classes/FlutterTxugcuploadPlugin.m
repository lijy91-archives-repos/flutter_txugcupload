#import "FlutterTxugcuploadPlugin.h"

@implementation FlutterTxugcuploadPlugin {
    FlutterEventSink _eventSink;
    TXUGCPublish *_txUgcPublish;
    NSString *customKey;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_txugcupload"
                                     binaryMessenger:[registrar messenger]];
    FlutterTxugcuploadPlugin* instance = [[FlutterTxugcuploadPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    FlutterEventChannel* eventChannel =
    [FlutterEventChannel eventChannelWithName:@"flutter_txugcupload/event_channel"
                              binaryMessenger:[registrar messenger]];
    [eventChannel setStreamHandler:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"setCustomKey" isEqualToString:call.method]) {
        [self setCustomKey:call result:result];
    } else if ([@"publishVideo" isEqualToString:call.method]) {
        [self publishVideo:call result:result];
    } else if ([@"publishMedia" isEqualToString:call.method]) {
        [self publishMedia:call result:result];
    } else if ([@"cancelPublish" isEqualToString:call.method]) {
        [self cancelPublish:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    _eventSink = eventSink;
    
    return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    _eventSink = nil;
    
    return nil;
}

- (void)setCustomKey:(FlutterMethodCall*)call
              result:(FlutterResult)result
{
    NSString *customKey = call.arguments[@"customKey"];
    
    if (self->_txUgcPublish == nil || (customKey != nil && ![customKey isEqualToString:self->customKey])) {
        self->_txUgcPublish = [[TXUGCPublish alloc] initWithUserID:customKey];
        self->_txUgcPublish.delegate = self;;
        self->_txUgcPublish.delegate = self;;
    }
    
    self->customKey = customKey;
}

- (void)publishVideo:(FlutterMethodCall*)call
              result:(FlutterResult)result
{
    TXPublishParam *param = [[TXPublishParam alloc] init];
    
    NSDictionary *paramJson = call.arguments[@"param"];
    if (paramJson) {
        NSString *signature = paramJson[@"signature"];
        NSString *videoPath = paramJson[@"videoPath"];
        NSString *coverPath = paramJson[@"coverPath"];
        NSNumber *enableResume = paramJson[@"enableResume"];
        NSNumber *enableHttps = paramJson[@"enableHttps"];
        NSString *fileName = paramJson[@"fileName"];
        
        if (signature)
            param.signature = signature;
        if (videoPath)
            param.videoPath = [videoPath stringByReplacingOccurrencesOfString:@"file://" withString:@""];;
        if (coverPath)
            param.coverPath = coverPath;
        if (enableResume)
            param.enableResume = [enableResume boolValue];
        if (enableHttps)
            param.enableHTTPS = [enableHttps boolValue];
        if (fileName)
            param.fileName = fileName;
        
    }
    
    int ret = [self->_txUgcPublish publishVideo:param];
    result([NSNumber numberWithInt:ret]);
}

- (void)publishMedia:(FlutterMethodCall*)call
              result:(FlutterResult)result
{
    TXMediaPublishParam *param = [[TXMediaPublishParam alloc] init];
    
    NSDictionary *paramJson = call.arguments[@"param"];
    if (paramJson) {
        NSString *signature = paramJson[@"signature"];
        NSString *mediaPath = paramJson[@"mediaPath"];
        NSNumber *enableResume = paramJson[@"enableResume"];
        NSNumber *enableHttps = paramJson[@"enableHttps"];
        NSString *fileName = paramJson[@"fileName"];
        
        if (signature)
            param.signature = signature;
        if (mediaPath)
            param.mediaPath = [mediaPath stringByReplacingOccurrencesOfString:@"file://" withString:@""];;
        if (enableResume)
            param.enableResume = [enableResume boolValue];
        if (enableHttps)
            param.enableHTTPS = [enableHttps boolValue];
        if (fileName)
            param.fileName = fileName;
    }
    
    int ret = [self->_txUgcPublish publishMedia:param];
    result([NSNumber numberWithInt:ret]);
}

- (void)cancelPublish:(FlutterMethodCall*)call
               result:(FlutterResult)result
{
    [self->_txUgcPublish canclePublish];
    
    result([NSNumber numberWithBool:YES]);
}

#pragma mark - TXVideoPublishListener
-(void) onPublishProgress:(NSInteger)uploadBytes totalBytes: (NSInteger)totalBytes
{
    NSDictionary<NSString *, id> *eventData = @{
        @"listener": @"TXVideoPublishListener",
        @"method": @"onPublishProgress",
        @"data": @{
                @"uploadBytes": @(uploadBytes),
                @"totalBytes": @(totalBytes)
        }
    };
    self->_eventSink(eventData);
}

-(void) onPublishComplete:(TXPublishResult*)videoResult
{
    NSDictionary<NSString *, id> *eventData = @{
        @"listener": @"TXVideoPublishListener",
        @"method": @"onPublishComplete",
        @"data": @{
                @"result": @{
                        @"retCode": @(videoResult.retCode),
                        @"descMsg": videoResult.descMsg != nil ? videoResult.descMsg : @"",
                        @"videoId": videoResult.videoId != nil ? videoResult.videoId : @"",
                        @"videoURL": videoResult.videoURL != nil ? videoResult.videoURL : @"",
                        @"coverURL": videoResult.coverURL != nil ? videoResult.coverURL : @"",
                }
        }
    };
    self->_eventSink(eventData);
}


#pragma mark - TXMediaPublishListener
-(void) onMediaPublishProgress:(NSInteger)uploadBytes totalBytes: (NSInteger)totalBytes
{
    NSDictionary<NSString *, id> *eventData = @{
        @"listener": @"TXMediaPublishListener",
        @"method": @"onMediaPublishProgress",
        @"data": @{
                @"uploadBytes": @(uploadBytes),
                @"totalBytes": @(totalBytes)
        }
    };
    self->_eventSink(eventData);
}

-(void) onMediaPublishComplete:(TXMediaPublishResult*)mediaResult
{
    NSDictionary<NSString *, id> *eventData = @{
        @"listener": @"TXMediaPublishListener",
        @"method": @"onMediaPublishComplete",
        @"data": @{
                @"result": @{
                        @"retCode": @(mediaResult.retCode),
                        @"descMsg": mediaResult.descMsg != nil ? mediaResult.descMsg : @"",
                        @"mediaId": mediaResult.mediaId,
                        @"mediaURL": mediaResult.mediaURL,
                }
        }
    };
    self->_eventSink(eventData);
}

@end
