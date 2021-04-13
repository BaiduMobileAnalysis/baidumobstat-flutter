#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "BaiduMobStat.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [BaiduMobStat defaultStat].enableDebugOn = YES;
    [[BaiduMobStat defaultStat] startWithAppId:@"69c633afd3"];

    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
