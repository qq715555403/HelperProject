//
//  AppDelegate.h
//  HelperProject
//
//  Created by hushijun on 15/8/8.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "Book.h"
#import "Appirater.h"
#import "MTStatusBarOverlay.h"


#define UMENG_APPKEY @"55efa20e67e58e47ba0005ad"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

