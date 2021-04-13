import 'dart:async';

import 'package:flutter/services.dart';

class BaiduMobStatFlutter {
  static const MethodChannel _channel =
      const MethodChannel('baidu_mob_stat');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 记录一次事件的点击。
  /// 
  /// [eventId] 自定义事件ID，请提前在网站上创建，未创建的evenId记录将无效。
  /// [attributes] 事件属性，对应的key需要在网站上创建，未创建的key记录将无效。
  static void logEvent(String eventId, [Map<String, String> attributes]) {
    _channel.invokeMethod('logEvent', [eventId, attributes]);
  }

  /// 记录一次事件的时长。
  /// 
  /// [eventId] 自定义事件ID，请提前在网站上创建，未创建的evenId记录将无效。
  /// [duration] 已知的自定义事件时长，单位为毫秒（ms）。
  /// [attributes] 事件属性，对应的key需要在网站上创建，未创建的key记录将无效。
  static void logDurationEvent(String eventId, int duration, [Map<String, String> attributes]) {
    _channel.invokeMethod('logDurationEvent', [eventId, duration, attributes]);
  }

  /// 记录一次事件的开始。
  /// 
  /// [eventId] 自定义事件ID，请提前在网站上创建，未创建的evenId记录将无效。
  static void eventStart(String eventId) {
    _channel.invokeMethod('eventStart', eventId);
  }

  /// 记录一次事件的开始。
  /// 
  /// [eventId] 自定义事件ID，请提前在网站上创建，未创建的evenId记录将无效。
  /// [attributes] 事件属性，对应的key需要在网站上创建，未创建的key记录将无效。
  static void eventEnd(String eventId, [Map<String, String> attributes]) {
    _channel.invokeMethod('eventEnd', [eventId, attributes]);
  }

  /// 记录某个页面访问的开始。
  /// 
  /// [name] 页面名称
  static void pageStart(String name) {
    _channel.invokeMethod('pageStart', name);
  }

  /// 记录某个页面访问的结束。
  /// 
  /// [name] 页面名称
  static void pageEnd(String name) {
    _channel.invokeMethod('pageEnd', name);
  }

  /// 获取SDK生成的设备的cuid
  static Future<String> getDeviceCuid() async {
    return await _channel.invokeMethod('getDeviceCuid');
  }

  /// 获取SDK生成的设备的测试ID
  static Future<String> getTestDeviceId() async {
    return await _channel.invokeMethod('getTestDeviceId');
  }
}
