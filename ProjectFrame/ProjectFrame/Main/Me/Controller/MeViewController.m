//
//  MeViewController.m
//  ProjectFrame
//
//  Created by tsc on 17/1/20.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@property (nonatomic, strong) YYFPSLabel *fpsLabel;


@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!_fpsLabel) {
        _fpsLabel = [YYFPSLabel new];
        _fpsLabel.frame=CGRectMake(20, 80, 30, 30);
        [_fpsLabel sizeToFit];
        _fpsLabel.alpha = 0.6;
        [self.view addSubview:_fpsLabel];
    }
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
