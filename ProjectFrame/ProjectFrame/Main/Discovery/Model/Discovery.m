//
//  Discovery.m
//  ProjectFrame
//
//  Created by tsc on 17/1/20.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "Discovery.h"

@implementation Discovery

#warning 指定模型数组中模型的类型
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"Data" : @"DiscoveryDataModel"};
}

@end

@implementation DiscoveryDataModel

#warning 重写这个方法是因为在FCModel里面初始化时有个nil的key，不清楚为什么
- (id)valueForKey:(NSString *)key {
    
    if (key) {
        return [super valueForKey:key];
    }
    else
        return nil;
    
}
@end

