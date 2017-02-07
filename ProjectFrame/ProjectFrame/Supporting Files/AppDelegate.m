//
//  AppDelegate.m
//  ProjectFrame
//
//  Created by tsc on 17/1/16.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLPlusButtonSubclass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [[UMSocialManager defaultManager] openLog:YES];
    
    [self configUShareSettings];
    
    [self configUSharePlatforms];

    [CYLPlusButtonSubclass registerPlusButton];
    
    BaseTabBarControllerConfig *config = [[BaseTabBarControllerConfig alloc] init];

    self.window.rootViewController = config.tabBarController;
    
    [self.window makeKeyAndVisible];
    
    /*初始化数据库**/
    [BaseDataBaseModel initDataBase:@"test1" dataSheets:@[@"Discovery"] operation:nil];
    
    /*监控网络状态**/
    [self monitorNetworkStatus];
    
    return YES;
}

//#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

//#endif

/**/
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
     BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
     if (!result) {
         // 其他如支付等SDK的回调
     }
     return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/*监控网络状态**/
- (void)monitorNetworkStatus {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/*友盟配置**/
- (void)configUShareSettings
{
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms{
    
    BOOL canOpenWechat = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]];
    BOOL canOpenQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    BOOL canOpenAlipay = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey: SINA_APPKEY  appSecret:SINA_APPSECRET redirectURL:REDIRECT_URL];
    
    if (canOpenWechat) {
        /* 设置微信的appKey和appSecret */
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APPKEY appSecret:WECHAT_APPSECRET redirectURL:REDIRECT_URL];
        
        /* 移除相应平台的分享，如微信收藏 */
        [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    }
    
    if (canOpenQQ) {
        /* 设置分享到QQ互联的appID
         * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
         */
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPKEY appSecret:QQ_APPSECRET redirectURL:REDIRECT_URL];
    }
    
    if (canOpenAlipay) {
        /* 支付宝的appKey */
        [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:ALIPAY_APPKEY appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    }

}

@end
