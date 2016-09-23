//
//  PasswordInputWindow.h
//  HelperProject
//
//  Created by hushijun on 15/8/20.
//  Copyright (c) 2015年 hushijun. All rights reserved.
/*
 
 app进入后台之后，密码window
 */


#import <UIKit/UIKit.h>

@interface PasswordInputWindow : UIWindow

+(PasswordInputWindow *) sharedInstance;

-(void) show;
@end
