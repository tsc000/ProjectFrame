//
//  BaseNavigationController.m
//  ProjectFrame
//
//  Created by tsc on 17/1/16.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count >= 1) {

        viewController.hidesBottomBarWhenPushed = YES;
        
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_top"] forBarMetrics:0];
        
    }
    [super pushViewController:viewController animated:animated];
    
}



@end
