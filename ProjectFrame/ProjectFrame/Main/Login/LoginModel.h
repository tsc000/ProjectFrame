//
//  LoginModel.h
//  ProjectFrame
//
//  Created by tsc on 17/1/19.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginDataModel;

@interface LoginModel : BaseResponseModel

@property (nonatomic, strong) LoginDataModel *Data;

@end

@interface LoginDataModel : NSObject

@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *designer_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_mobile;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *user_pic;
@property (nonatomic, assign) NSInteger user_type;

@end
