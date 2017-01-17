//
//  NetworkTool.h
//  video
//
//  Created by TSC on 16/4/18.
//  Copyright © 2016年 TSC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBoundary @"boundary"

//成功回调Block
typedef void(^Success)(id obj, id response);

//成功回调Block
typedef void(^success)(id obj, NSURLResponse *response);

//失败回调Block
typedef void(^failure)(NSError *error);


@interface NetworkTool : NSObject

//单例接口

+(instancetype)sharedNetworkTool;

/**
 *  加载网络服务器资源
 *
 *  @param urlString 资源定位
 *  @param success   成功回调
 *  @param failure   失败回调
 */
-(void)loadWebServerDataWithUrlString:(NSString *)urlString success:(success)success failure:(failure)failure;

/**
 *  post上传单文件
 *
 *  @param urlString 服务器资源定位
 *  @param filename  上传的文件在服务器中显示的名称
 *  @param filekey   上传的文件对应的key（一般由后台给出）
 *  @param filepath  上传文件的本地路径
 *  @param success   成功回调
 *  @param failure   失败回调
 */
- (void)PostFileWithURLString:(NSString *)urlString FileName:(NSString *)filename FileKey:(NSString *)filekey FilePath:(NSString *)filepath Success:(success)success Failure:(failure)failure;


/**
 *  post多文件+多普通文本参数,也可作单文件上传
 *
 *  @param urlString  服务器资源定位
 *  @param fileDict   filename:filepath
 *  @param parameters 多个普通文本参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)PostFilesWithURLString:(NSString *)urlString FileKeyAndPathDict:(NSMutableDictionary *)fileDict Parameters:(NSMutableDictionary *) parameters success:(success)success failure:(failure)failure;

/**
 *  get请求数据
 *
 *  @param urlString 资源定位
 *  @param parameter key:value
 *  @param success   成功回调
 *  @param failure   失败回调
 */
- (void)getWithURLString:(NSString *)urlString Parameter:(NSMutableDictionary *)parameter success:(success)success failure:(failure)failure;

/**
 *  post请求数据
 *
 *  @param urlString 资源定位
 *  @param parameter key:value
 *  @param success   成功回调
 *  @param failure   失败回调
 */
- (void)postWithURLString:(NSString *)urlString Parameter:(NSMutableDictionary *)parameter success:(success)success failure:(failure)failure;

/**
 *
 *
 *  @param filePath 本地文件路径
 *
 *  @return 响应信息
 */
- (NSURLResponse *)getFileResponseWithFilePath:(NSString *)filePath;

- (void)POST:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(failure)failure;

//DYLW 接口
- (void)postWithServiceCode:(NSString*)serviceCode params:(NSDictionary*)paramDict success:(Success)successBlock failure:(failure)failureBlock;

@end
