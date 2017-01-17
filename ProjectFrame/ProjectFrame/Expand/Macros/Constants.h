//
//  Constants.h
//  TSC
//
//  Created by tsc on 17/1/10.
//  Copyright © 2017年 TSC. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

/*获取当前语言**/
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/*控件数值常量**/
#define kScreenWidth    [[UIScreen mainScreen] bounds].size.height
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.width

//#define StatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kStatusBarHeight        20.0f
#define kNavigationBarHeight    44.0f
#define kTabBarHeight           49.0f

#define kContentViewHeight (kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)

/*由角度获取弧度 由弧度获取角度**/
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

/*项目常用简写**/
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define LGNotificationCenter [NSNotificationCenter defaultCenter]

#define VIEW_withTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

#define SAVEUSERDEFAULT(__value__,__key__)      [USER_DEFAULT setObject:__value__ forKey:__key__]
#define GETUSERDEFAULT(__key__)                 [USER_DEFAULT objectForKey:__key__]
#define REMOVEUSERDEFAULT(__key__)              [USER_DEFAULT removeObjectForKey:__key__]

/*G－C－D**/
//在Global Queue上运行
#define DISPATCH_ON_GLOBAL_QUEUE_HIGH(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_DEFAULT(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_LOW(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_BACKGROUND(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), globalQueueBlocl);
//在Main线程上运行
#define DISPATCH_ON_MAIN_THREAD(block) dispatch_async(dispatch_get_main_queue(),block)

/*设置颜色**/
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define RandomColor [rUIColor colorWithRed:((arc4random()%255)/255.0) green:((arc4random()%255)/255.0) blue:((arc4random()%255)/255.0) alpha:1.0f];

/*清除背景色**/
#define CLEARCOLOR [UIColor clearColor]

/*设置字体**/
#define FONT(size) [UIFont systemFontOfSize:size]

/*读取本地图片**/
#define LoadImageWithSufix(resource,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:resource ofType:type]]

#define LoadImage(resource) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:resource ofType:nil]]

/*文档路径**/
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/*安全字符串**/
#define SAFESTRING(str)  ( ( ((str)!=nil)&&![(str) isKindOfClass:[NSNull class]])?[NSString stringWithFormat:@"%@",(str)]:@"" )

/*字符串是否为空**/
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
/*数组是否为空**/
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
/*字典是否为空**/
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
/*是否是空对象**/
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

/*App版本号**/
#define appMPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/*获取系统版本**/
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

/*检查系统版本**/
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/*Device**/
#define retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//iPhone5       分辨率320x568，像素640x1136
//iPhone6       分辨率375x667，像素750x1334
//iPhone6Plus   分辨率414x736，像素1242x2208，@3x，（注意，在这个分辨率下渲染后，图像等比降低pixel分辨率至1080p(1080x1920)

/* 是否IOS6**/
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
/* 是否大于等于IOS7**/
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
/* 是否大于等于IOS8**/
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
/* 是否大于IOS9**/
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
/* 是否iPad**/
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


/*判断是真机还是模拟器**/
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#pragma mark--单例
// 单例模式
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#ifdef DEBUG
#define NSLog(fmt, ...)  NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...)
#endif

#ifdef DEBUG
#define CSQLog( s, ... ) NSLog( @"<%@:%d>%@ %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithUTF8String:__PRETTY_FUNCTION__], [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define CSQLog(...)
#endif


#endif /* Constants_h */
