//
//  ShareHelper.h
//  HelperProject
//
//  Created by hushijun on 15/9/24.
//  Copyright © 2015年 hushijun. All rights reserved.
//

#import <Foundation/Foundation.h>
//＝＝＝＝＝＝＝＝＝＝ShareSDK简单版头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//以下是ShareSDK必须添加的依赖库：
//1、libicucore.dylib
//2、libz.dylib
//3、libstdc++.dylib
//4、JavaScriptCore.framework
//＝＝＝＝＝＝＝＝＝＝以下是各个平台SDK的头文件，根据需要继承的平台添加＝＝＝
//微信SDK头文件
#import "WXApi.h"
//以下是微信SDK的依赖库：
//libsqlite3.dylib

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

//＝＝＝＝＝＝＝＝＝＝ShareSDK简单版头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

@interface ShareHelper : NSObject

+(ShareHelper *)sharedInstance;        //状态栏展示活动指示器

//注册shareSDK
+(void)registerShareSDKWithAppID:(NSString *) appID weixinID:(NSString *) weixinID weixinAppSecret:(NSString *) weixinAppSecret;


@end
