//
//  Discovery.m
//  ProjectFrame
//
//  Created by tsc on 17/1/20.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "Discovery.h"

@implementation Discovery

+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"Data" : @"DiscoveryDataModel"
              };
}


//+ (void)setupTransform
//{
//    [[self class] mj_setupObjectClassInArray:^NSDictionary *{
//        return @{ @"Data" : @"DiscoveryDataModel"
//                  };
//    }];
//    
////    [[self class] mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
////        return @{
////                 @"Datas" : @"Data"
////                 };
////    }];
//}

@end

@implementation DiscoveryDataModel

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}

- (id)valueForKey:(NSString *)key {
    
    if (key) {
        return [super valueForKey:key];
    }
    else
        return nil;
    
}
@end

