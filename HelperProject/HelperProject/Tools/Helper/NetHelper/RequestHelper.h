//
//  RequestHelper.h
//  AFNetworkTest
//
//  Created by hushijun on 15/5/8.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefine.h"

//#import "GDataXMLNode.h"  //xml解析

////定义请求成功和请求失败的块
typedef void (^AFNRequestSuccessBlock)(NSDictionary *results, NSData *data);
typedef void (^AFNRequestFailureBlock)(NSDictionary *results, NSError *error);

typedef NSURL* (^AFNDownloadToPathBlock)(NSURL *targetPath, NSURLResponse *response);
typedef void (^AFNDownloadCompletionBlock)(NSURLResponse *response, NSURL *filePath, NSError *error);
typedef void (^AFNUploadCompletionBlock)(NSURLResponse *response, id responseObject, NSError *error);

//使用AFHTTPRequestOperation下载成功失败块
typedef void (^AFNRequestOperationSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^AFNRequestOperationFailBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface RequestHelper : NSObject
{
    NSMutableDictionary *requests;  //存放请求的字典集合
    BOOL isAlertStatusActivity; //是否提示状态栏活动指示器
}

+(RequestHelper *)sharedInstance;        //状态栏展示活动指示器
+(RequestHelper *)sharedInstanceNoAlert; //状态栏不展示活动指示器

#pragma mark - 检测3G是否可用
+ (BOOL)checkNetworkIs3G;

#pragma mark  检测WiFi是否可用
+ (BOOL)checkNetworkIsWiFi;

#pragma mark  检测网络是否可用
+ (BOOL)checkNetwork;

#pragma mark  检测网络是否可用带错误信息
+ (BOOL)checkNetwork:(NSString *)errorMessage;

#pragma mark - 获取时间戳，标记请求
- (NSString *)getTimeStamp;

#pragma mark - get请求：使用块
- (NSURLSessionDataTask *)getWithUrl:(NSString *)urlString
                               param:(NSDictionary *)requestInfo
                             success:(AFNRequestSuccessBlock)success
                             failure:(AFNRequestFailureBlock)failure;

#pragma mark  post请求：单url：使用块
- (NSURLSessionDataTask *)postWithUrl:(NSString *)urlString
                                param:(NSDictionary *)requestInfo
                              success:(AFNRequestSuccessBlock)success
                              failure:(AFNRequestFailureBlock)failure;

#pragma mark  post请求：集中管理url：使用块
- (NSURLSessionDataTask *)postWithType:(RequestType)requestType
                                 param:(NSDictionary *)requestInfo
                               success:(AFNRequestSuccessBlock)success
                               failure:(AFNRequestFailureBlock)failure;

#pragma mark - 下载任务
-(NSURLSessionDownloadTask *)downloadTaskWithUrl:(NSString *)urlString
                                      completion:(AFNDownloadCompletionBlock) complete;

#pragma mark - 下载任务
-(NSURLSessionDownloadTask *)downloadTaskWithUrl:(NSString *)urlString
                                          toPath:(AFNDownloadToPathBlock) destination
                                      completion:(AFNDownloadCompletionBlock) complete;

-(AFHTTPRequestOperation *)downLoadOperationWithUrl:(NSString *) urlString
                                             toPath:(NSString *) toPath
                                            success:(AFNRequestOperationSuccessBlock) success
                                            failure:(AFNRequestOperationFailBlock) failure;

#pragma mark  上传任务
-(NSURLSessionUploadTask *)uploadTaskWithUrl:(NSString *)urlString
                                    fromPath:(NSString *)fromPath
                                  completion:(AFNUploadCompletionBlock) complete;

#pragma mark  上传任务-带进度的文件上传
-(NSURLSessionUploadTask *)uploadTaskWithUrl:(NSString *)urlString
                                    fromPath:(NSString *)fromPath
                                        name:(NSString *)name
                                    fileName:(NSString *)fileName
                                  completion:(AFNUploadCompletionBlock) complete;





#pragma mark - 取消所有请求
///普通网络请求、上传任务请求、下载任务请求
-(void) cancelAllRequest;

//#pragma mark  取消所有网络请求
//-(void) cancelAllDataRequest;
//
//#pragma mark  取消所有上传请求
//-(void) cancelAllUploadRequest;
//
//#pragma mark  取消所有下载请求
//-(void) cancelAllDownloadRequest;




@end