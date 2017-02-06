//
//  HomeViewController.m
//  ProjectFrame
//
//  Created by tsc on 17/1/18.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginModel.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"Mobile"] = @"13522493206";
    dict[@"Pwd"] = @"123456";
    
    [[NetworkTool sharedNetworkTool] postWithServiceCode:@"User_Mobile_Login" params:dict success:^(id obj, id response) {
        
#warning 模型嵌套模型
        LoginModel *base =  [LoginModel mj_objectWithKeyValues:response];
        
        NSLog(@"%@-----%@",base.Message,base.Data.user_mobile);
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
