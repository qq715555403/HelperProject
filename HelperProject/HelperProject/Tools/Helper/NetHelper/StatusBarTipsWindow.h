//
//  StatusBarTipsWindow.h
//  demo
//
//  Created by hushijun on 15/4/27.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AppDelegate.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define HEIGHT   20

#define TipsFont [UIFont systemFontOfSize:13]   //提示信息字体
#define TipsColor [UIColor whiteColor]          //提示信息字体颜色

#define ICON_WIDTH 17
#define IconLeftMargin   10
#define AnimateDuration  0.5           //动画持续时间
#define AnimateHiddenAfter  1.0        //动画多久消失时间
#define AnimateHiddenAlertAfter  3.0   //提示动画多久消失时间

//#define TIPMESSAGE_RIGHT_MARGIN 20
//#define ICON_RIGHT_MARGIN       5


@interface StatusBarTipsWindow : UIWindow

/*
 * @brief get the singleton tips window
 */
+ (StatusBarTipsWindow *)shareTipsWindow;

/*
 * @brief show tips message on statusBar
 */
- (void)showTips:(NSString*)tips;

/*
 * @brief show tips message on statusBar
 */
- (void)showTips:(NSString*)tips hideAfterDelay:(NSInteger)seconds;

/*
 * @brief show tips icon and message on statusBar
 */
- (void)showTipsWithImage:(UIImage*)tipsIcon message:(NSString*)message;

/*
 * @brief show tips icon and message on statusBar
 */
- (void)showTipsWithImage:(UIImage*)tipsIcon message:(NSString*)message hideAfterDelay:(NSInteger)seconds;

//2015-07-21 17:15:35 add by 胡仕君：增加默认图片的提示框
- (void)showTipsWithImageAndMessage:(NSString*)message;
- (void)showTipsWithImageAndMessage:(NSString*)message hideAfterDelay:(NSInteger)seconds;

/*
 * @brief hide tips window
 */
- (void)hideTips;

@end
