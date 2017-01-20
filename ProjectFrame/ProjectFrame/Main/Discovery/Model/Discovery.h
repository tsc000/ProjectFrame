//
//  Discovery.h
//  ProjectFrame
//
//  Created by tsc on 17/1/20.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "FCModel.h"

@class DiscoveryDataModel;

@interface Discovery : BaseResponseModel

@property (nonatomic, strong) NSArray *Datas;

+ (void)setupTransform;

@end

@interface DiscoveryDataModel : FCModel

@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_pic;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *goods_url;

@end
