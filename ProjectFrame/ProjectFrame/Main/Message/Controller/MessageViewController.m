//
//  MessageViewController.m
//  ProjectFrame
//
//  Created by tsc on 17/1/20.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *Btn=[UIButton new];
    Btn.tag=1001;
    Btn.backgroundColor = [UIColor redColor];
    [Btn setTitle:@"分享" forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
    [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(50);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-50);
        make.centerY.mas_equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(40);
    }];
 
}

-(void)btnPressed:(id)sender {

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //标题
    messageObject.title = @"友盟分享";
    //设置文本
    messageObject.text = @"欢迎使用【友盟+】社会化组件U-Share";
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {

        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            
            
        }];
        
    }];
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
