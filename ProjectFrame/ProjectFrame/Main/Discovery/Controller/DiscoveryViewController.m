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

    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    dict[@"Type"] = @"1";
    
    dict[@"Keyword"] = @"小";

    [[NetworkTool sharedNetworkTool] postWithServiceCode:@"Search_Keyword" params:dict success:^(id obj, id response) {

        Discovery *discovery = [Discovery mj_objectWithKeyValues:response];

        [discovery.Data enumerateObjectsUsingBlock:^(DiscoveryDataModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            DiscoveryDataModel *dataModel = [DiscoveryDataModel instanceWithPrimaryKey:obj.goods_url];

            [dataModel save:^{

                dataModel.goods_name = obj.goods_name;
                
                dataModel.goods_pic = obj.goods_pic;
                
                dataModel.goods_price = obj.goods_price;

                dataModel.goods_url = obj.goods_url;
            }];
        }];
        
//        for (DiscoveryDataModel *data in discovery.Data) {
//            NSString *goods_url = data.goods_url;
//            NSString *goods_pic = data.goods_pic;
//            NSString *goods_name = data.goods_name;
//            NSLog(@"text=%@, name=%@, icon=%@", goods_url, goods_pic, goods_name);
//        }

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
