package com.baidu.baidu_mob_stat_example;

import android.os.Bundle;
import com.baidu.mobstat.StatService;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // 调试模式下，打开log开关，可以看到调试log
        StatService.setDebugOn(true);
        // 设置app发布渠道
        StatService.setAppChannel(this, "appChannel", true);
        // 设置app版本号
        StatService.setAppVersionName(this, "1.0");
        // 设置Appkey
        StatService.setAppKey("testAppkey");
        // 启动sdk
        StatService.start(this);
    }
}
