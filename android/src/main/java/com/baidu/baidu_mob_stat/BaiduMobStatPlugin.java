package com.baidu.baidu_mob_stat;

import android.content.Context;

import androidx.annotation.NonNull;

import com.baidu.mobstat.StatService;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * BaiduMobStatPlugin
 */
public class BaiduMobStatPlugin implements FlutterPlugin, MethodCallHandler {
    public Context mContext;

    // The MethodChannel that will the communication between Flutter and native Android
    //
    // mContext local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private MethodChannel channel;


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "baidu_mob_stat");
        channel.setMethodCallHandler(this);
        mContext = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        try {
            if (call.method.equals("getPlatformVersion")) {

                // 系统版本
                result.success("Android " + android.os.Build.VERSION.RELEASE);
            } else if (call.method.equals("logEvent")) {

                // 普通事件
                JSONArray jsonArray = new JSONArray(call.arguments.toString());
                String eventId = jsonArray.get(0).toString();
                Map<String, String> attributes = changeToMap((JSONObject) jsonArray.get(1));
                StatService.onEvent(mContext, eventId, "", 1, attributes);
            } else if (call.method.equals("logDurationEvent")) {

                // 带时常事件
                JSONArray jsonArray = new JSONArray(call.arguments.toString());
                String eventId = jsonArray.get(0).toString();
                int duration = (int) jsonArray.get(1);
                Map<String, String> attributes = changeToMap((JSONObject) jsonArray.get(2));
                StatService.onEventDuration(mContext, eventId, "", duration, attributes);
            } else if (call.method.equals("eventStart")) {

                // 事件的开始
                StatService.onEventStart(mContext, (String) call.arguments, "");
            } else if (call.method.equals("eventEnd")) {

                // 事件的结束
                JSONArray jsonArray = new JSONArray(call.arguments.toString());
                String eventId = jsonArray.get(0).toString();
                Map<String, String> attributes = changeToMap((JSONObject) jsonArray.get(1));
                StatService.onEventEnd(mContext, eventId, "", attributes);
            } else if (call.method.equals("pageStart")) {

                // 页面开始
                StatService.onPageStart(mContext, (String) call.arguments);
            } else if (call.method.equals("pageEnd")) {

                // 页面结束
                StatService.onPageEnd(mContext, (String) call.arguments);
            } else if (call.method.equals("getTestDeviceId")) {

                // 获取测试cuid
                result.success(StatService.getTestDeviceId(mContext));
            } else {
                result.notImplemented();
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }


    public HashMap<String, String> changeToMap(JSONObject record) {
        HashMap<String, String> map = new HashMap<>();
        try {
            @SuppressWarnings("rawtypes")
            Iterator it = record.keys();
            while (it.hasNext()) {
                String key = String.valueOf(it.next()).toString();
                String value = (String) record.get(key).toString();
                map.put(key, value);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return map;
    }

}
