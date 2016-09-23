//
//  CPToast.h
//  demo
//
//  Created by hushijun on 15/4/27.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface CPToast : NSObject


+(void)toast:(NSString*) msg onView:(UIView*)view;
+(void)toast:(NSString *)msg onView:(UIView *)view andYoffset:(double)yOffset;

//弹出提示
+(void) alertTitle:(NSString *) title andMessage:(NSString *) msg;
+(void) alertTitle:(NSString *) title andMessage:(NSString *) msg delegate:(id) delegate btnTitle:(NSString *) btnTitle;
+(void) alertTitle:(NSString *) title  delegate:(id) delegate btnTitle:(NSString *) btnTitle otherBtnTitles:(NSString *) otherTitle;
+(void) alertTitle:(NSString *) title andMessage:(NSString *) msg delegate:(id) delegate btnTitle:(NSString *) btnTitle otherBtnTitles:(NSString *) otherTitle;

//显示隐藏活动指示器
+(void) addMBProgressHUD:(NSString *) title toView:(UIView *) view;
+(void) hiddenMBProgressHUDForView:(UIView *) view;


@end
