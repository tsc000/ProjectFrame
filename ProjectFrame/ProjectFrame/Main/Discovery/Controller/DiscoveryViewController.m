//
//  DiscoveryViewController.m
//  ProjectFrame
//
//  Created by tsc on 17/1/20.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "Discovery.h"

@interface DiscoveryViewController ()

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [BaseDataBaseModel initDataBase:@"test" dataSheets:@[@"Login"] operation:nil];
    
    [BaseDataBaseModel initDataBase:@"test1" dataSheets:@[@"Discovery"] operation:nil];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    dict[@"Type"] = @"1";
    
    dict[@"Keyword"] = @"小";

    [[NetworkTool sharedNetworkTool] postWithServiceCode:@"Search_Keyword" params:dict success:^(id obj, id response) {
        
        [Discovery setupTransform];
        
        Discovery *discovery = [Discovery mj_objectWithKeyValues:response];
        
//        NSError *err = nil;
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:0 error:&err];
//        
//        NSLog(@"%@",json);
        
        
        for (DiscoveryDataModel *data in discovery.Data) {
            NSString *goods_url = data.goods_url;
            NSString *goods_pic = data.goods_pic;
            NSString *goods_name = data.goods_name;
            NSLog(@"text=%@, name=%@, icon=%@", goods_url, goods_pic, goods_name);
        }

    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
