//
//  RequestHelper.m
//  AFNetworkTest
//
//  Created by hushijun on 15/5/8.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "RequestHelper.h"
//#import "SDDataCache.h"
//#import <CommonCrypto/CommonDigest.h>
//#import "NSDictionaryXMLParser.h"


static BOOL isFirst = NO;
static BOOL canCheckNetwork = NO;

@implementation RequestHelper

+(RequestHelper *)sharedInstance
{
    static RequestHelper *sharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[RequestHelper alloc] init];
    });
    return sharedService;
}

+(RequestHelper *)sharedInstanceNoAlert{
    static RequestHelper *sharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[RequestHelper alloc] initWithNoAlert];
    });
    return sharedService;
}

- (id) init
{
    if (self = [super init])
    {
        //1、初始化请求字典集合
        requests = [[NSMutableDictionary alloc] init];
        isAlertStatusActivity=YES;
    }
    
    return self;
}

//2015-08-17 19:22:35 by 胡仕君：不显示活动指示器
- (id) initWithNoAlert
{
    if (self = [super init])
    {
        //1、初始化请求字典集合
        requests = [[NSMutableDictionary alloc] init];
        isAlertStatusActivity=NO;
    }
    
    return self;
}


#pragma mark - 开启网络监听
+ (void) startNetworkMonitoring
{
//    //1..检查网络连接(苹果公司提供的检查网络的第三方库 Reachability)
//    //AFN 在 Reachability基础上做了一个自己的网络检查的库, 基本上一样
//    if (isFirst == NO) {
//        //网络只有在startMonitoring完成后才可以使用检查网络状态
//        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            canCheckNetwork = YES;
//        }];
//        isFirst = YES;
//    }
    
    
    __block BOOL isConnect;
    __block NSString *str;
    
    //1..检查网络连接(苹果公司提供的检查网络的第三方库 Reachability)
    //AFN 在 Reachability基础上做了一个自己的网络检查的库, 基本上一样
    if (isFirst == NO) {
        //网络只有在startMonitoring完成后才可以使用检查网络状态
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            canCheckNetwork = YES;
            
            // 之所以区分无线和3G主要是为了替用户省钱，省流量
            // 如果应用程序占流量很大，一定要提示用户，或者提供专门的设置，仅在无线网络时使用！
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    str=@"无线网络";
                    isConnect=YES;
                }break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    str=@"3G网络";
                    isConnect=YES;
                }break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    str=@"未连接";
                    isConnect=NO;
                }break;
                case AFNetworkReachabilityStatusUnknown:
                {
                    str=@"未知错误";
                    isConnect=NO;
                }break;
                    
                default:{
                    str=@"未知";
                    isConnect=NO;
                }break;
            }
            
//            NSLog(@"块里:当前网络状态==%@,isconnect==%d",str,isConnect);
        }];
        isFirst = YES;
    }
    
    //    ?为什么这里获取不到str的值呢？
//    NSLog(@"块外:当前网络状态==%@,isconnect==%d",str,isConnect);
    //    return isConnect;
}

#pragma mark  检测3G是否可用
+ (BOOL)checkNetworkIs3G
{
//    1.开启网络监听
    [self startNetworkMonitoring];
    
    //只能在监听完善之后才可以调用
    BOOL is3GOK = [[AFNetworkReachabilityManager sharedManager]isReachableViaWWAN];
    //网络有问题
    if(is3GOK == NO && canCheckNetwork == YES){
        DLog(@"AFN->3G网络不可用");
        return NO;
    }else{
        DLog(@"AFN->3G网络可用");
        return YES;
    }
}

#pragma mark  检测WiFi是否可用
+ (BOOL)checkNetworkIsWiFi
{
    //    1.开启网络监听
    [self startNetworkMonitoring];
    
    //只能在监听完善之后才可以调用
    BOOL isWifiOK = [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
    
    //网络有问题
    if(isWifiOK == NO && canCheckNetwork == YES){
        DLog(@"AFN->WiFi网络不可用");
        return NO;
    }else{
        DLog(@"AFN->WiFi网络可用");
        return YES;
    }
}


#pragma mark  检测网络是否可用
+ (BOOL)checkNetwork
{
    //    1.开启网络监听
    [self startNetworkMonitoring];

    //只能在监听完善之后才可以调用
    BOOL isOK = [[AFNetworkReachabilityManager sharedManager] isReachable];
    
    //网络有问题
    if(isOK == NO && canCheckNetwork == YES){
        DLog(@"AFN->网络不可用");
        return NO;
    }else{
        DLog(@"AFN->网络可用");
        return YES;
    }
}


#pragma mark  检测网络是否可用带错误信息
+ (BOOL)checkNetwork:(NSString *)errorMessage
{
    //    1.开启网络监听
    [self startNetworkMonitoring];
    
    //只能在监听完善之后才可以调用
    BOOL isOK = [[AFNetworkReachabilityManager sharedManager] isReachable];
    //网络有问题
    if(isOK == NO && canCheckNetwork == YES){
        if (errorMessage && errorMessage.length>0) {
            [StatusBarTipsWindowClass showTipsWithImageAndMessage:[NSString stringWithFormat:@"%@",errorMessage]  hideAfterDelay:AnimateHiddenAfter];
        }
        DLog(@"AFN->网络不可用");
        return NO;
    }else{
        DLog(@"AFN->网络可用");
        return YES;
    }
}


#pragma mark - 获取时间戳，标记请求
- (NSString *)getTimeStamp
{
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f",timestamp];
}


#pragma mark  url解析方法
-(NSString *) createURLStringByURLRequestType:(RequestType) requestType
{
    //    domain:http://114.251.197.211
    //    ServerDomainUrl http://114.251.197.211/ICCard/
//    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    
    NSString *domain = Main_Domain_Url;
    NSString *strUrl=nil;
    switch (requestType) {
        case RequestTypeMD5:
        {
            strUrl=[NSString stringWithFormat:@"%@%@",domain,UrlMD5];
            //strUrl=@"http://114.251.197.211/ICCard/GetLimitNumber.aspx";
        }break;

        case RequestTypeYijianFankui:
        {
            strUrl=[NSString stringWithFormat:@"%@%@",domain,UrlYijianFankui];
            //strUrl=@"http://114.251.197.211/ICCard/GetLimitNumber.aspx";
        }break;
            
        default:{
            strUrl=nil;
        }break;
    }
    
    return strUrl;
}


#pragma mark - get请求：使用块
- (NSURLSessionDataTask *)getWithUrl:(NSString *)urlString
                               param:(NSDictionary *)requestInfo
                             success:(AFNRequestSuccessBlock)success
                             failure:(AFNRequestFailureBlock)failure
{
    DLog(@" \nGET请求: url : %@ \nparam==%@",urlString,requestInfo);
    //    检查网络，如果网络不可用，则退出
    if ([RequestHelper checkNetwork]==NO) {
        if (failure) {
            NSError *error = [NSError errorWithDomain:@"无网络连接" code:RequestErrorNotNetwork userInfo:nil];
            DLog(@"AFN检测无网络连接:error.localizedDescription==%@,error.code==%d",error.localizedDescription,(int)error.code);
            failure(nil, error);
        }
        return nil;
    }
    
    //    判断该url是否存在
    if ([NSString isEmptyOfString:urlString]) {
        if (failure) {
            NSError *error = [NSError errorWithDomain:@"URL为空" code:RequestErrorUrlEmpty userInfo:nil];
            DLog(@"URL为空:error.localizedDescription==%@,error.code==%d",error.localizedDescription,(int)error.code);
            failure(nil, error);
        }
        return nil;
    }
    
    //如果字典数据存在，则将数据追加到urlString之后
    if (requestInfo.count>0) {
        for (NSString* key in requestInfo.keyEnumerator) {
            NSString* value = [requestInfo objectForKey:key];
            //NSLog(@"%s,value==%@",__FUNCTION__,value);
            urlString=[NSString stringWithFormat:@"%@&%@=%@",urlString,key,value];
        }
    }
    
    //2015-08-17 19:22:35 by 胡仕君：不显示活动指示器
    if (isAlertStatusActivity) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }else{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    // 设置请求格式
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // Content-Type 表示的是请求报文体的 MIME 类型，在 POST 和 PUT 请求中必须存在，在 GET 等请求中可以忽略此项。
    // 对于 HTTP 响应而言 Content-Type 是必需的
    // 设置响应正文类型为text/html
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 设置网络连接超时时间
    sessionManager.requestSerializer.timeoutInterval=30.0f;
    
    NSURLSessionDataTask *task =[sessionManager GET:urlString parameters:requestInfo success:^(NSURLSessionDataTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [requests removeObjectForKey:task.taskDescription];
        

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    //                NSLog(@"200--->Received:responseObject== %@", responseObject);
//                    NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                    //                NSLog(@"result: %@", result);
//                    NSData *jsonData=[result dataUsingEncoding:NSUTF8StringEncoding];
//                    //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
//                    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];

                    NSDictionary* dic=(NSDictionary *)responseObject;
                    NSLog(@"200--->dic: %@,dic.count===%d", dic,(int)dic.count);
                    success(dic, responseObject);
                });
            }
        } else {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSError *error = [NSError errorWithDomain:@"服务器错误" code:httpResponse.statusCode userInfo:nil];
                    DLog(@"非200--->Received: %@\n服务器错误:error.localizedDescription==%@,error.code==%d",responseObject,error.localizedDescription,(int)error.code);
                    failure(nil, error);
                });
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [requests removeObjectForKey:task.taskDescription];

        if (error.code==-999) {
            NSLog(@"task<%@>,网络请求取消",task.taskDescription);
        }else{
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    DLog(@"error.localizedDescription==%@,error.code==%d",error.localizedDescription,(int)error.code);
                    failure(nil, error);
                });
            }
        }
    }];

    task.taskDescription=[self getTimeStamp];

    //将请求任务添加到请求集合中，方便统一管理请求移除
    [requests setObject:task forKey:task.taskDescription];
    
//    DLog(@"requests.count==%d",(int)requests.count);
    
    return task;
}

#pragma mark  post请求：单url：使用块
- (NSURLSessionDataTask *)postWithUrl:(NSString *)urlString
                                param:(NSDictionary *)requestInfo
                              success:(AFNRequestSuccessBlock)success
                              failure:(AFNRequestFailureBlock)failure
{
    DLog(@" \nPOST请求: url : %@ \nparam==%@",urlString,requestInfo);
    //    检查网络，如果网络不可用，则退出
    if ([RequestHelper checkNetwork:NetErrorInfo]==NO) {
//    if ([RequestHelper checkNetwork]==NO) {
        if (failure) {
            NSError *error = [NSError errorWithDomain:@"无网络连接" code:RequestErrorNotNetwork userInfo:nil];
            DLog(@"AFN检测无网络连接:error.localizedDescription==%@,error.code==%d",error.localizedDescription,(int)error.code);
            failure(nil, error);
        }
        return nil;
    }
    
    //    判断该url是否存在
    if ([NSString isEmptyOfString:urlString]) {
        if (failure) {
            NSError *error = [NSError errorWithDomain:@"URL为空" code:RequestErrorUrlEmpty userInfo:nil];
            DLog(@"URL为空:error.localizedDescription==%@,error.code==%d",error.localizedDescription,(int)error.code);
            failure(nil, error);
        }
        return nil;
    }
    
    //2015-08-17 19:22:35 by 胡仕君：不显示活动指示器
    if (isAlertStatusActivity) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }else{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    // 设置请求格式:默认是AFHTTPRequestSerializer
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 设置返回格式
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // Content-Type 表示的是请求报文体的 MIME 类型，在 POST 和 PUT 请求中必须存在，在 GET 等请求中可以忽略此项。
    // 对于 HTTP 响应而言 Content-Type 是必需的
    // 设置响应正文类型为text/html
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 设置网络连接超时时间
    sessionManager.requestSerializer.timeoutInterval=30.0f;
    
    NSURLSessionDataTask *task =[sessionManager POST:urlString parameters:requestInfo success:^(NSURLSessionDataTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [requests removeObjectForKey:task.taskDescription];
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"200--->Received:responseObject== %@", responseObject);
                    
                    NSDictionary* dic=(NSDictionary *)responseObject;
                    NSLog(@"JSONResponse--->dic: %@,dic.count===%d", dic,(int)dic.count);
                    
                    success(dic, responseObject);
                });
            }
        } else {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSError *error = [NSError errorWithDomain:@"服务器错误" code:httpResponse.statusCode userInfo:nil];
                    DLog(@"非200--->Received: %@\n服务器错误:error.localizedDescription==%@,error.code==%d",responseObject,error.localizedDescription,(int)error.code);
                    failure(nil, error);
                });
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [requests removeObjectForKey:task.taskDescription];
        
        if (error.code==-999) {
            NSLog(@"task<%@>,网络请求取消",task.taskDescription);
        }else{
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    DLog(@"error.localizedDescription==%@,error.code==%d",error.localizedDescription,(int)error.code);
                    failure(nil, error);
                });
            }
        }
    }];
    
    task.taskDescription=[self getTimeStamp];
    
    //将请求任务添加到请求集合中，方便统一管理请求移除
    [requests setObject:task forKey:task.taskDescription];
    
//    DLog(@"requests.count==%d",(int)requests.count);
    
    return task;
}

#pragma mark  post请求：集中管理url：使用块
- (NSURLSessionDataTask *)postWithType:(RequestType)requestType
                                 param:(NSDictionary *)requestInfo
                               success:(AFNRequestSuccessBlock)success
                               failure:(AFNRequestFailureBlock)failure
{
    //    根据urlModelType获取对应的url，并判断该url是否存在
    NSString *urlString=[self createURLStringByURLRequestType:requestType];
    NSURLSessionDataTask *task =[self postWithUrl:urlString param:requestInfo success:success failure:failure];
    
    return task;
}

#pragma mark - 下载任务
-(NSURLSessionDownloadTask *)downloadTaskWithUrl:(NSString *)urlString
                                      completion:(AFNDownloadCompletionBlock) complete
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSProgress *progress=[NSProgress currentProgress];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];

    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        complete(response,filePath,error);
    }];
    
    NSLog(@"totalUnitCount===%lld",progress.totalUnitCount);
    NSLog(@"completedUnitCount===%lld",progress.completedUnitCount);
    
    [downloadTask resume];
    
    return downloadTask;
}
#pragma mark  下载任务
-(NSURLSessionDownloadTask *)downloadTaskWithUrl:(NSString *)urlString
                                          toPath:(AFNDownloadToPathBlock) destination
                                      completion:(AFNDownloadCompletionBlock) complete
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSProgress *progress=[NSProgress currentProgress];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:destination completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        complete(response,filePath,error);
    }];
    
    [downloadTask resume];
    
    NSLog(@"totalUnitCount===%lld",progress.totalUnitCount);
    NSLog(@"completedUnitCount===%lld",progress.completedUnitCount);
    
    return downloadTask;
}

-(AFHTTPRequestOperation *)downLoadOperationWithUrl:(NSString *) urlString
                                             toPath:(NSString *) toPath
                                            success:(AFNRequestOperationSuccessBlock) success
                                            failure:(AFNRequestOperationFailBlock) failure
{
    // 1.   指定下载文件地址
//    NSURL *url = [NSURL URLWithString:@"http://169.254.98.245/~apple/itcast/download/iTunesConnect_DeveloperGuide_CN.zip"];

//    107M
//    NSURL *url = [NSURL URLWithString:@"https://developer.apple.com/library/ios/samplecode/Adventure-Swift/AdventureBuildingaSpriteKitGameUsingSwift.zip"];

    //47k
//    NSURL *url = [NSURL URLWithString:@"https://developer.apple.com/library/ios/samplecode/GeocoderDemo/GeocoderDemo.zip"];
    //8M
//    NSURL *url = [NSURL URLWithString:@"https://developer.apple.com/library/ios/samplecode/AVCustomEdit/AVCustomEdit.zip"];

    NSURL *url = [NSURL URLWithString:urlString];
    // 2.   指定文件保存路径
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);

//    NSString *downloadPath = [documents[0]stringByAppendingPathComponent:@"book.zip"];
    NSString *downloadPath = [documents[0]stringByAppendingPathComponent:toPath];
    NSLog(@"downloadPath==%@",downloadPath);


    // 3.   创建NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.   通过固定请求,创建AFURLConnectionOperation,多态
    AFHTTPRequestOperation *operation= [[AFHTTPRequestOperation alloc] initWithRequest:request];
    // 5.   设置操作的输出流（在网络中的数据是以流的方式传输的，
    //告诉操作把文件保存在第2步设置的路径中）
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:downloadPath append:NO]];
    // 6.   设置下载进程处理块代码
    // 6.1 bytesRead 读取的字节——这一次下载的字节数
    // 6.2 totalBytesRead 读取的总字节——已经下载完的
    // 6.3 totalBytesExpectedToRead 希望读取的总字节——就是文件的总大小
//    __weak RequestServiceHelper *myself = self;
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead,
//                                          long long totalBytesRead, long long totalBytesExpectedToRead) {
//        float test=(float)totalBytesRead / totalBytesExpectedToRead;
//        // 做下载进度百分比的工作
//        NSLog(@"下载百分比：%f", test);
//        [myself.progressView setProgress:test];
//        NSMutableString *str=[NSMutableString stringWithFormat:@"下载进度: %.2lf ",test*100];
//        [str appendString:@" %"];
//        myself.lblInfo.text=str;
//    }];
    // 7.   操作完成块代码
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // 解压缩的顺序
//        // 1. 定义要解压缩的文件 —— downloadPath
//        // 2. 要解压缩的目标目录,必须是目录
//        // 3. 调用类方法解压缩
//        [SSZipArchive unzipFileAtPath:downloadPath toDestination:documents[0]];
//        // 使用文件管理者,删除压缩包
//        [[NSFileManager defaultManager]removeItemAtPath:downloadPath error:nil];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"下载失败，error==%@",error.localizedDescription);
//    }];
    
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    // 8   启动操作
    [operation start];
    
    return operation;
}

#pragma mark  上传任务
-(NSURLSessionUploadTask *)uploadTaskWithUrl:(NSString *)urlString
                                    fromPath:(NSString *)fromPath
                                    completion:(AFNUploadCompletionBlock) complete
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
//    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURL *filePath = [NSURL fileURLWithPath:fromPath];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
        complete(response,responseObject,error);
    }];
    [uploadTask resume];
    
    return uploadTask;
}

#pragma mark  上传任务-带进度的文件上传
-(NSURLSessionUploadTask *)uploadTaskWithUrl:(NSString *)urlString
                                    fromPath:(NSString *)fromPath
                                        name:(NSString *)name
                                    fileName:(NSString *)fileName
                                  completion:(AFNUploadCompletionBlock) complete
{
    /**
     *  appendPartWithFileURL
     */
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
//    } error:nil];
    
    AFHTTPRequestSerializer *requestSerializer=[AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fromPath] name:name fileName:fileName mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
        complete(response,responseObject,error);
    }];
    [uploadTask resume];
    
    return uploadTask;
    
//    /**
//     *  NSURLSessionDataTask
//     */
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
////    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
//    NSURL *URL = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
//        completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//        }
//        complete(response,responseObject,error);
//    }];
//    [dataTask resume];
//    return dataTask;
    
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURL *url = [NSURL URLWithString:@"http://cdn.sencha.com/ext/gpl/ext-4.2.1-gpl.zip"];
//    
//    // http://www.w3hacker.com/wp-content/uploads/2013/10/180.jpg
//    // http://cdn.sencha.com/ext/gpl/ext-4.2.1-gpl.zip
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        
//        NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
//        return [documentsDirectoryPath URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"File downloaded to: %@", filePath);
//    }];
//    
//    [downloadTask resume];
//    
//    [self.progressView setProgressWithDownloadProgressOfTask:downloadTask animated:YES];

    
}

#pragma mark - 取消所有请求
///普通网络请求、上传任务请求、下载任务请求
-(void) cancelAllRequest
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    DLog(@"移除前：requests.count==%d",(int)requests.count);
//    DLog(@"移除前：\nrequests.count==%d,\nrequests==%@",requests.count,requests);
    if (requests.count>0) {
        for (NSObject *obj in requests.allValues) {
            
            NSURLSessionTask *taskTemp=(NSURLSessionTask *)obj;
//            NSLog(@"taskTemp==%@",taskTemp);
            [taskTemp cancel];
        }
    }

    //移除请求数组
    [requests removeAllObjects];
    
    DLog(@"移除后：requests.count==%d",(int)requests.count);
}
//#pragma mark  取消所有网络请求
//-(void) cancelAllDataRequest
//{
////    NSLog(@"self==%@，[RequestHelper class]==%@",self,[RequestHelper class]);
////    BOOL isDataTemp=[self isMemberOfClass:[RequestHelper class]];
////    if (isDataTemp) {
////        NSLog(@"取消普通请求");
////    }else{
////        NSLog(@"isDataTemp==no");
////    }
//    
////    为什么task是__NSCFLocalDataTask类型的对象？？？
////    requests=={
////        "1437634106.680733" = "<__NSCFLocalDataTask: 0x14771330>{ taskIdentifier: 1 } { canceling }";
////        "1437634106.688189" = "<__NSCFLocalDataTask: 0x14774990>{ taskIdentifier: 1 } { canceling }";
////        "1437634106.693915" = "<__NSCFLocalDataTask: 0x1452f2f0>{ taskIdentifier: 1 } { canceling }";
////    }
//    
//    
//    NSLog(@"移除前：\nrequests.count==%d,\nrequests==%@",requests.count,requests);
//    if (requests.count>0) {
//        for (NSObject *obj in requests.allValues) {
//            NSLog(@"obj==%@，[NSURLSessionDataTask class]==%@",obj,[NSURLSessionDataTask class]);
//            BOOL isData=[obj isMemberOfClass:[NSURLSessionDataTask class]];
//            if (isData) {
//                NSLog(@"取消普通请求");
//                NSURLSessionDataTask *task=(NSURLSessionDataTask *)obj;
//                [task cancel];
//                
//                [requests removeObjectForKey:task.taskDescription];
//            }else{
//                NSLog(@"isData==no");
//            }
//                
//        }
//    }
//    
//    NSLog(@"移除后：\nrequests.count==%d,\nrequests==%@",requests.count,requests);
//}
//
//#pragma mark  取消所有上传请求
//-(void) cancelAllUploadRequest
//{
//    NSLog(@"取消前：\nrequests.count==%d,\nrequests==%@",requests.count,requests);
//    if (requests.count>0) {
//        for (NSObject *obj in requests.allValues) {
//            
//            if ([obj isMemberOfClass:[NSURLSessionUploadTask class]]) {
//                NSLog(@"取消上传请求");
//                NSURLSessionUploadTask *task=(NSURLSessionUploadTask *)obj;
//                [task cancel];
//                
//                [requests removeObjectForKey:task.taskDescription];
//            }
//        }
//    }
//    NSLog(@"移除后：\nrequests.count==%d,\nrequests==%@",requests.count,requests);
//}
//#pragma mark  取消所有下载请求
//-(void) cancelAllDownloadRequest
//{
//    NSLog(@"取消前：\nrequests.count==%d,\nrequests==%@",requests.count,requests);
//    if (requests.count>0) {
//        for (NSObject *obj in requests.allValues) {
//            if ([obj isMemberOfClass:[NSURLSessionDownloadTask class]]) {
//                NSLog(@"取消下载请求");
//                NSURLSessionDownloadTask *task=(NSURLSessionDownloadTask *)obj;
//                [task cancel];
//                
//                [requests removeObjectForKey:task.taskDescription];
//            }
//        }
//    }
//    NSLog(@"移除后：\nrequests.count==%d,\nrequests==%@",requests.count,requests);
//}





//AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//// 设置请求格式
//manager.requestSerializer = [AFJSONRequestSerializer serializer];
//manager.requestSerializer.timeoutInterval=60.0f;//设置请求超时时间
//// 设置返回格式
//manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//[manager GET:strXLH parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    
//    [StatusBarTipsWindowClass hideTips];
//    
//    //            NSLog(@"JSON: %@", responseObject);
//    NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//    NSLog(@"result: %@", result);
//    NSData *jsonData=[result dataUsingEncoding:NSUTF8StringEncoding];
//    //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
//    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"dic: %@,dic.count===%d,ret==%@", dic,(int)dic.count,dic[@"ret"]);
//    
//    if (dic && [dic[@"ret"] isEqualToString:@"0"]) {  //如果网络请求数据出错
//        NSString * errorInfo=dic[@"err"];
//        NSLog(@"网络请求成功返回数据，但查询结果出问题，提示具体问题");
//        [self endFirstRotaAnimation];
//        [StatusBarTipsWindowClass showTipsWithImageAndMessage:errorInfo hideAfterDelay:AnimateHiddenAfter];
//    } else {  //如果网络请求数据正常
//        //                _dicPhoneInfo = dic;
//        NSLog(@"网络请求成功返回数据，本地数据和网络数据2合1之后出结果");
//        [self dealRequestResultInfoWithDic:dic];
//    }
//    
//} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    NSLog(@"Error: %@", error);
//    
//    [StatusBarTipsWindowClass hideTips];
//    
//    BOOL isOK=[self queryOfflineDeviceInfo];
//    if (!isOK) { //数据无法正常算出，则直接提示网络问题
//        NSLog(@"网络请求错误，直接结束旋转，提示错误网络错误");
//        [self endFirstRotaAnimation];
//        [StatusBarTipsWindowClass showTipsWithImageAndMessage:NetErrorInfo hideAfterDelay:AnimateHiddenAfter+0.5];
//    }else{ //数据正常算出，则进入下一步数据处理
//        NSLog(@"网络请求错误，本地数据能计算出结果，直接出结果");
//        [self initDataNew];
//        //同时开启旋转和插入row的动画
//        [self beginSuccessAnimation];
//    }
//    
//}];


//设置请求头
//AFHTTPRequestReaderOperationManager *manager = [AFHTTPRequestReaderOperationManager manager];
//manager.requestSerializer = [AFJSONRequestSerializer serializer];
//manager.responseSerializer = [AFJSONResponseSerializer serializer];
//
//[ manager.requestSerializer setValue:xx forHTTPHeaderField:xx]
//
//不设置请求头，可能也能用
//NSMutableURLRequest请求设置请求头，AFN不设置好像也能用，我的代码测试是可以的

@end
