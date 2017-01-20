//
//  NetworkTool.m
//  video
//
//  Created by TSC on 16/4/18.
//  Copyright © 2016年 TSC. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworking.h" //AFN

static id _instance;

@implementation NetworkTool

+ (instancetype)sharedNetworkTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (void)loadWebServerDataWithUrlString:(NSString *)urlString success:(success)success failure:(failure)failure {
    
    //%号转义
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //建立资源定位符
    NSURL *url = [NSURL URLWithString:urlString];
    
    //建立请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //发送网络请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //处理结果
        [self handleResultWithData:data Response:response Error:error Success:success Failure:failure];
        
    }] resume];
}

//post单文件
- (void)PostFileWithURLString:(NSString *)urlString FileName:(NSString *)filename FileKey:(NSString *)filekey FilePath:(NSString *)filepath Success:(success)success Failure:(failure)failure {
    
    //服务器资源定位
    NSURL *url = [NSURL URLWithString:urlString];
    
    //建立请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    //设置请求属性
    request.HTTPMethod = @"post";
    request.HTTPBody = [self getHTTPBodyWithFileName:filename FileKey:filekey FilePath:filepath];
    
    NSString *type = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBoundary];
    
    //响应头信息
    [request setValue:type forHTTPHeaderField:@"Content-Type"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        [self handleResultWithData:data Response:response Error:error Success:success Failure:failure];
        
    }] resume];
    
}

- (NSData *) getHTTPBodyWithFileName:(NSString *)filename FileKey:(NSString *)filekey FilePath:(NSString *)filepath {
    
    NSMutableString *bodyHeader = [NSMutableString string];
    NSURLResponse *response = [self getFileResponseWithFilePath:filepath];
    if (!filename) { //服务器中显示的文件名为空
        filename = response.suggestedFilename;
    }
    //上边界
    [bodyHeader appendFormat:@"\r\n--%@\r\n",kBoundary];
    
    [bodyHeader appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@ Content-Type: %@\r\n\r\n", filekey ,filename,response.MIMEType];
    
    //文件内容
    NSString *fileContent = [NSString stringWithContentsOfFile:@"/Users/apple/Desktop/解压密码.txt" encoding:NSUTF8StringEncoding error:nil];
    
    [bodyHeader appendFormat:@"%@",fileContent];
    
    //下边界
    [bodyHeader appendFormat:@"\r\n--%@--",kBoundary];
    
    //    NSLog(@"%@",bodyHeader);
    //转换成二进制数据，HTTPBody要用
    NSData *data = [bodyHeader dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

//post多文件+多普通文本参数
- (void)PostFilesWithURLString:(NSString *)urlString FileKeyAndPathDict:(NSDictionary *)fileDict Parameters:(NSDictionary *) parameters success:(success)success failure:(failure)failure {
    
    //服务器资源定位
    NSURL *url  = [NSURL URLWithString:urlString];
    
    //建立请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //配置请求属性
    request.HTTPMethod = @"post";
    request.HTTPBody = [self getHTTPBodysWithFileNameAndPathDict:fileDict Parameters:parameters];
    
    //配置响应头信息
    NSString *type = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBoundary];
    
    [request setValue:type forHTTPHeaderField:@"Content-Type"];
    
    //发送网络请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        [self handleResultWithData:data Response:response Error:error Success:success Failure:failure];
        
    }] resume];
    
}

- (NSData *) getHTTPBodysWithFileNameAndPathDict:(NSDictionary *)fileDict Parameters:(NSDictionary *) parameters {
    
    //所有的东西都统一用content保存，是为了打印数据和firebug获取的数据格式比较（调度）
    NSMutableString *content = [NSMutableString string];

    
    [fileDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *fileName = key;
        NSString *filePath = obj;
        //文件边界
        [content appendFormat:@"\r\n--%@",kBoundary];
        
        [content appendFormat:@"\r\nContent-Disposition: form-data; name=%@; filename=%@",@"userfile[]",fileName];
        [content appendFormat:@"\r\nContent-Type: application/octet-stream\r\n\r\n"];
        
        NSURLResponse *response = [self getFileResponseWithFilePath:filePath];
        if (!fileName ||!fileName.length) { //服务器中显示的文件名为空
            fileName = response.suggestedFilename;
        }
        
        //文件内容
        NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [content appendString:fileContent];
    }];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *parameterKey = key;
        NSString *parametername = obj;
        [content appendFormat:@"\r\n--%@",kBoundary];
        [content appendFormat:@"\r\nContent-Disposition: form-data; name=%@\r\n\r\n",parameterKey];
        [content appendFormat:@"%@\r\n",parametername];
    }];
    
    //文件下边界
    [content appendFormat:@"--%@--\r\n",kBoundary]; //不清楚为什么这里写不写都行
    NSLog(@"%@",content);
    
    NSMutableData *data = [NSMutableData data];
    [data appendData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    
    return data;
}

//多参数get数据请求
- (void)getWithURLString:(NSString *)urlString Parameter:(NSDictionary *)parameter success:(success)success failure:(failure)failure {
    
    NSMutableString *content = [NSMutableString string];
    
    [content appendString:urlString];//
    [content appendString:@"?"];//
    
    [parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [content appendFormat:@"%@=%@&",key,obj];
        
    }];
    
    NSString *finalurl = [content substringToIndex:content.length-1];
    
    NSURL *url = [NSURL URLWithString:finalurl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        [self handleResultWithData:data Response:response Error:error Success:success Failure:failure];
        
    }] resume];
    NSLog(@"%@",finalurl);
}

//多参数post数据请求
- (void)postWithURLString:(NSString *)urlString Parameter:(NSDictionary *)parameter success:(success)success failure:(failure)failure{
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString *body = [NSMutableString string];
    
    [parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [body appendFormat:@"%@=%@&",key,obj];
    }];
    [body substringToIndex:body.length - 1];
    
    NSData *data =[body dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody = data;
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        [self handleResultWithData:data Response:response Error:error Success:success Failure:failure];
    }] resume];
}


/**
 *  处理成功和失败请求
 *
 *  @param data     服务器返回来的数据
 *  @param response 响应头
 *  @param error    错误信息
 *  @param success  成功回调
 *  @param failure  失败回调
 */
- (void)handleResultWithData:(NSData *) data Response:(NSURLResponse *)     response  Error:(NSError *) error Success:(success)success Failure:(failure)failure{
    if (data && !error) { //成功响应
        
        id responseObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //是否可以转成JSON文件
        
        if (!responseObj) { //不可转换，将数据原样返回
            responseObj = data;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(responseObj,response);
            }
        });
    }
    else { //不成功
        if (failure) {
            failure(error);
        }
    }

}

/**
 *
 *
 *  @param filePath 本地文件路径
 *
 *  @return 响应信息
 */
- (NSURLResponse *)getFileResponseWithFilePath:(NSString *)filePath{
    
    NSString *urlString = [NSString stringWithFormat:@"file://%@",filePath];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __block NSURLResponse *tempResponse = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            tempResponse = response;
        }];
        
    });
    
    
    //ios 9.0 之前,connection方法
//    NSError *error = nil;
//    [NSURLConnection sendSynchronousRequest:request returningResponse:&tempResponse error:&error];
//    NSLog(@"sss%@",error);
    
    
    return tempResponse;
}

- (void)POST:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(failure)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                success(nil,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);

    }];
    
    
//    - (AFHTTPRequestOperation *)POST:(NSString *)URLString
//parameters:(id)parameters
//success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
    
//    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        success(nil,responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        failure(error);
//    }];
}

//DYLW 接口
- (void)postWithServiceCode:(NSString*)serviceCode params:(NSDictionary*)paramDict success:(Success)successBlock failure:(failure)failureBlock
{
    if(serviceCode.length==0)
        return;

    NSString *url = @"http://dylw.test.csq365.com/app/index";
    
    NSString * urlStr=[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];

    NSString *jsonString = [paramDict JSONString];

    dict[@"A"] = serviceCode;
    
    dict[@"P"] =  jsonString;
    
    [self POST:urlStr parameters:dict success:^(id obj, id response) {
        
        successBlock(nil,response);
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


@end
