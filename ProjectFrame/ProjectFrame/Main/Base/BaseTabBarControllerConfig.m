//
//  BaseTabBarControllerConfig.m
//  ProjectFrame
//
//  Created by tsc on 17/1/18.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "BaseTabBarControllerConfig.h"
#import "HomeViewController.h"

@implementation BaseTabBarControllerConfig

- (BaseTabBarController *)tabBarController {
    
    if (!_tabBarController) {
        
        BaseTabBarController *tabBarController = [BaseTabBarController tabBarControllerWithViewControllers:[self viewControllers] tabBarItemsAttributes:[self tabBarItemsAttributesForController]];
        
        
//        [self customizeTabBarAppearance:tabBarController];
        
        _tabBarController = tabBarController;
        
    }
    return _tabBarController;
}


/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
#warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
    tabBarController.tabBarHeight = 40.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (NSArray *)viewControllers {
    HomeViewController *firstViewController = [[HomeViewController alloc] init];
    UIViewController *firstNavigationController = [[BaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    HomeViewController *secondViewController = [[HomeViewController alloc] init];
    UIViewController *secondNavigationController = [[BaseNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    HomeViewController *thirdViewController = [[HomeViewController alloc] init];
    UIViewController *thirdNavigationController = [[BaseNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    HomeViewController *fourthViewController = [[HomeViewController alloc] init];
    UIViewController *fourthNavigationController = [[BaseNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    //tabBarController.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    //tabBarController.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 //                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"home_normal",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"home_highlight", /* NSString and UIImage are supported*/
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  //                                                  CYLTabBarItemTitle : @"同城",
                                                  CYLTabBarItemImage : @"mycity_normal",
                                                  CYLTabBarItemSelectedImage : @"mycity_highlight",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 //                                                 CYLTabBarItemTitle : @"消息",
                                                 CYLTabBarItemImage : @"message_normal",
                                                 CYLTabBarItemSelectedImage : @"message_highlight",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  //                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"account_normal",
                                                  CYLTabBarItemSelectedImage : @"account_highlight"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

@end
