//
//  Discovery.m
//  ProjectFrame
//
//  Created by tsc on 17/1/20.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "Discovery.h"

@implementation Discovery

+ (void)setupTransform
{
    [[self class] mj_setupObjectClassInArray:^NSDictionary *{
        return @{ @"Data" : @"DiscoveryDataModel"
                  };
    }];
    
//    [[self class] mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"Datas" : @"Data"
//                 };
//    }];
}

@end

@implementation DiscoveryDataModel

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}
@end

