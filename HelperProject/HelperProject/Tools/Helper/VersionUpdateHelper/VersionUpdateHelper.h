//
//  VersionUpdateHelper.h
//  HelperProject
//
//  Created by hushijun on 15/8/17.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionUpdateHelper : NSObject
{
    BOOL isForced;//是否强制更新
}

@property(copy,nonatomic) NSString *appUrl;  //应用程序再appstore中的网络地址

+(VersionUpdateHelper *)sharedInstance;

//检测版本更新
- (void)checkVersion;

@end
