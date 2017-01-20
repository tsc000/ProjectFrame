//
//  BaseDataBaseModel.h
//  ProjectFrame
//
//  Created by tsc on 17/1/20.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDataBaseModel : FCModel

+ (void)initDataBase:(NSString *)dataBaseName dataSheets:(NSArray *)sheets operation:(void (^)(FMDatabase *db)) block;

@end
