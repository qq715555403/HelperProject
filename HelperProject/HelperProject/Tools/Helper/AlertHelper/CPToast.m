//
//  CPToast.m
//  demo
//
//  Created by hushijun on 15/4/27.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import "CPToast.h"

@implementation CPToast


+(void)toast:(NSString *)msg onView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Configure for text only and offset down
    //    hud.mode = MBProgressHUDModeCustomView;//自定义活动指示器形式
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = msg;
    hud.detailsLabelFont=[UIFont systemFontOfSize:13];
    hud.margin = 10.0f;
    hud.yOffset =0;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground=NO;
    [hud hide:NO afterDelay:2];
}

+(void)toast:(NSString *)msg onView:(UIView *)view andYoffset:(double)yOffset
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = msg;
    hud.detailsLabelFont=[UIFont systemFontOfSize:13];
    hud.margin = 10.0f;
    hud.yOffset = yOffset;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground=NO;
    [hud hide:NO afterDelay:1.0f];
}

+(void) alertTitle:(NSString *) title andMessage:(NSString *) msg
{
    [self alertTitle:title andMessage:msg delegate:nil btnTitle:@"确定"];
}

+(void) alertTitle:(NSString *) title andMessage:(NSString *) msg delegate:(id) delegate btnTitle:(NSString *) btnTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:btnTitle otherButtonTitles:nil, nil];
    [alertView show];
}

+(void) alertTitle:(NSString *) title  delegate:(id) delegate btnTitle:(NSString *) btnTitle otherBtnTitles:(NSString *) otherTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:delegate cancelButtonTitle:btnTitle otherButtonTitles:otherTitle, nil];
    [alertView show];
}

+(void) alertTitle:(NSString *) title andMessage:(NSString *) msg delegate:(id) delegate btnTitle:(NSString *) btnTitle otherBtnTitles:(NSString *) otherTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:btnTitle otherButtonTitles:otherTitle, nil];
    [alertView show];
}


#pragma mark- 显示活动指示器
+(void) addMBProgressHUD:(NSString *) title toView:(UIView *) view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = title;
    [view bringSubviewToFront:hud];
}
#pragma mark 隐藏活动指示器
+(void) hiddenMBProgressHUDForView:(UIView *) view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}




@end
