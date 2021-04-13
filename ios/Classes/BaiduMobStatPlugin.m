#import "BaiduMobStatPlugin.h"
#import "BaiduMobStat.h"

@implementation BaiduMobStatPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel = [FlutterMethodChannel
      methodChannelWithName:@"baidu_mob_stat"
            binaryMessenger:[registrar messenger]];
  BaiduMobStatPlugin *instance = [[BaiduMobStatPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([call.method isEqualToString:@"logEvent"]) {
      NSString *eventId = call.arguments[0];
      NSDictionary *attributes = [self validArgument:call.arguments[1]];
      [[BaiduMobStat defaultStat] logEvent:eventId attributes:attributes];
      result(nil);
  } else if ([call.method isEqualToString:@"logDurationEvent"]) {
      NSString *eventId = call.arguments[0];
      NSInteger duration = [call.arguments[1] integerValue];
      NSDictionary *attributes = [self validArgument:call.arguments[2]];
      [[BaiduMobStat defaultStat] logEventWithDurationTime:eventId durationTime:duration attributes:attributes];
      result(nil);
  } else if ([call.method isEqualToString:@"eventStart"]) {
      [[BaiduMobStat defaultStat] eventStart:call.arguments];
      result(nil);
  } else if ([call.method isEqualToString:@"eventEnd"]) {
      NSString *eventId = call.arguments[0];
      NSDictionary *attributes = [self validArgument:call.arguments[1]];
      [[BaiduMobStat defaultStat] eventEnd:eventId attributes:attributes];
      result(nil);
  } else if ([call.method isEqualToString:@"pageStart"]) {
      [[BaiduMobStat defaultStat] pageviewStartWithName:call.arguments];
      result(nil);
  } else if ([call.method isEqualToString:@"pageEnd"]) {
      [[BaiduMobStat defaultStat] pageviewEndWithName:call.arguments];
      result(nil);
  } else if ([call.method isEqualToString:@"getDeviceCuid"]) {
      result([[BaiduMobStat defaultStat] getDeviceCuid]);
  } else if ([call.method isEqualToString:@"getTestDeviceId"]) {
      result([[BaiduMobStat defaultStat] getTestDeviceId]);
  }  else {
    result(FlutterMethodNotImplemented);
  }
}

// dart侧可选参数未传或传nil，oc侧接收到的是NSNull
- (id)validArgument:(id)argument {
    return [argument isEqual:[NSNull null]] ? nil : argument;
}

@end
