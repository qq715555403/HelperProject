//
//  TotalBaseViewController.h
//  demo
//
//  Created by hushijun on 15/5/5.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

/**
 *  所有vc的父类，用于控制系统tabbar的隐藏和self.view的背景色
 */

#import <UIKit/UIKit.h>

@interface TotalBaseViewController : UIViewController<UIGestureRecognizerDelegate>
{
    NSURLSessionDataTask *currTask;
}
//创建网络失败的图片视图和隐藏图片视图
-(void) createImageWithLostConnect;
-(void) createImageWithLostConnectWithErrorInfo:(NSString *) errorInfo;
-(void) hideImageWithLostConnect;

//失去网络连接的图片点击事件
-(void) imgLostConnectTaped:(UITapGestureRecognizer *) tap;

@end
