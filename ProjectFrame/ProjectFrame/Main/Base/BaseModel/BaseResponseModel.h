//
//  BaseResponseModel.h
//  ProjectFrame
//
//  Created by tsc on 17/1/19.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponseModel : NSObject

@property (nonatomic, assign) NSInteger ErrorCode;
@property (nonatomic, copy) NSString *Status;
@property (nonatomic, copy) NSString *Message;


@end
