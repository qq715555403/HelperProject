//
//  ASDepthModalViewController.m
//  ASDepthModal
//
//  Created by Philippe Converset on 03/10/12.
//  Copyright (c) 2012 AutreSphere.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ASDepthModalViewController.h"
#import "AppDelegate.h"

@interface ASDepthModalViewController ()
@property (nonatomic, strong) UIViewController *rootViewController; //存储window的rootViewController，用于控制显示和隐藏
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *popupView;
@property (nonatomic, assign) CGAffineTransform initialPopupTransform;;
@end

static NSTimeInterval const kModalViewAnimationDuration = 0.3;

@implementation ASDepthModalViewController
@synthesize popupView;
@synthesize rootViewController;
@synthesize coverView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor blackColor];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;                
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    self.rootViewController.view.transform = CGAffineTransformIdentity;
    self.rootViewController.view.bounds = self.view.bounds;
    self.rootViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
}

#pragma mark - 重置跟视图控制器
- (void)restoreRootViewController
{
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    AppDelegate *dele=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window =dele.window;
    [self.rootViewController.view removeFromSuperview];
    self.rootViewController.view.transform = window.rootViewController.view.transform;
    window.rootViewController = self.rootViewController;
}

- (void)dismiss
{
    [UIView animateWithDuration:kModalViewAnimationDuration
                     animations:^{
                         self.coverView.alpha = 0;
                         self.rootViewController.view.transform = CGAffineTransformIdentity;
                         self.popupView.transform = self.initialPopupTransform;
                     }
                     completion:^(BOOL finished) {
                         [self restoreRootViewController];
                     }];
}

- (void)animatePopupWithStyle:(ASDepthModalAnimationStyle)style
{
    switch (style) {
        case ASDepthModalAnimationGrow:
        {
            self.popupView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.initialPopupTransform = self.popupView.transform;
            [UIView animateWithDuration:kModalViewAnimationDuration
                             animations:^{
                                 self.popupView.transform = CGAffineTransformIdentity;
                             }];
        }break;
            
        case ASDepthModalAnimationShrink:
        {
            self.popupView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            self.initialPopupTransform = self.popupView.transform;
            [UIView animateWithDuration:kModalViewAnimationDuration
                             animations:^{
                                 self.popupView.transform = CGAffineTransformIdentity;
                             }];
        }break;
            
        default:
            self.initialPopupTransform = self.popupView.transform;
            break;
    }
}

#pragma mark - 弹出透明层视图
- (void)presentView:(UIView *)view withBackgroundColor:(UIColor *)color popupAnimationStyle:(ASDepthModalAnimationStyle)popupAnimationStyle;
{
    if(color != nil)
    {
        self.view.backgroundColor = color;
    }
    
    //获取主window
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    AppDelegate *dele=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window =dele.window;
    
    //设置根视图控制器为主window的根视图控制器
    self.rootViewController = window.rootViewController;
//    NSLog(@"window==%@<<<====>>>self.rootViewController==%@",window,self.rootViewController);

    self.view.transform = self.rootViewController.view.transform;
    self.rootViewController.view.transform = CGAffineTransformIdentity;
    
    //修改跟视图控制器的frame为（0,0）起点
    CGRect frame = self.rootViewController.view.frame;
    frame.origin = CGPointZero;
    self.rootViewController.view.frame = frame;
//    NSLog(@"<<<====>>>self.rootViewController.view==%@",self.rootViewController.view);
    
    [self.view addSubview:self.rootViewController.view];
    
    //将当前vc设置为window的rootViewController；
    window.rootViewController = self;
//    NSLog(@"<<<====>>>window.rootViewController==%@",self.rootViewController);
    
    //透明层的大背景视图
    self.coverView = [[UIView alloc] initWithFrame:self.rootViewController.view.bounds];
    self.coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.coverView.backgroundColor = [UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:0.7];
    self.coverView.backgroundColor = RGBAColor(5, 25, 42, 0.8);
    [self.view addSubview:self.coverView];
    
    //在透明层的大背景视图上增加的一个大按钮，用于控制透明层的消失
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.frame = self.coverView.bounds;
    [dismissButton addTarget:self action:@selector(handleCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.coverView addSubview:dismissButton];
    
    //弹出层视图
    self.popupView = [[UIView alloc] initWithFrame:view.frame];
    self.popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.popupView addSubview:view];
    [self.coverView addSubview:self.popupView];
    self.popupView.center = CGPointMake(self.coverView.bounds.size.width/2, self.coverView.bounds.size.height/2);
    
    //做的一个透明层渐变的动画
    self.coverView.alpha = 0;
    [UIView animateWithDuration:kModalViewAnimationDuration
                     animations:^{
//                         self.rootViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                         self.coverView.alpha = 1;
                     }];
    [self animatePopupWithStyle:popupAnimationStyle];
}

#pragma mark - 弹出透明层视图类方法
+ (void)presentView:(UIView *)view
{
    [self presentView:view withBackgroundColor:nil popupAnimationStyle:ASDepthModalAnimationDefault];
}

+ (void)presentView:(UIView *)view withBackgroundColor:(UIColor *)color popupAnimationStyle:(ASDepthModalAnimationStyle)popupAnimationStyle;
{
    ASDepthModalViewController *modalViewController;
    
    modalViewController = [[ASDepthModalViewController alloc] init];
    [modalViewController presentView:view withBackgroundColor:(UIColor *)color popupAnimationStyle:popupAnimationStyle];
}

+ (void)dismiss
{
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    AppDelegate *dele=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window =dele.window;
    
    if([window.rootViewController isKindOfClass:[ASDepthModalViewController class]])
    {
        ASDepthModalViewController *controller;
        
        controller = (ASDepthModalViewController *)window.rootViewController;
        [controller dismiss];
    }
}

#pragma mark - Action
- (void)handleCloseAction:(id)sender
{
    [self dismiss];
}

@end
