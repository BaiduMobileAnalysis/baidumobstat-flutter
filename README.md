# baidu_mob_stat

该工程是百度移动统计Flutter插件工程。
对于基于Flutter开发的APP，您可以按如下步骤使用百度移动统计SDK，完成基础的埋点统计和上报。
具体调用示例，可以参考example工程

## 集成方法
1. 在 Flutter 项目的 pubspec.yaml 文件中 dependencies 里面添加 baidu_mob_stat 依赖

 ```bash
 	dependencies:
  	  baidu_mob_stat: ^0.0.2
 ```

2. 执行 flutter packages get 命令安装插件
 ```bash
 	flutter packages get
 ```

3. 在ios 目录下执行 pod install 命令进行 iOS SDK 的集成

  ```bash
  cd ios
  pod install
  ```
  
## 详细集成文档
https://mtj.baidu.com/static/userguide/book/ios/h5/flutter.html

