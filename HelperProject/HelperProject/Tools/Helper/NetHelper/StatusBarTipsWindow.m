//
//  StatusBarTipsWindow.m
//  demo
//
//  Created by hushijun on 15/4/27.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import "StatusBarTipsWindow.h"



@interface StatusBarTipsWindow () {
    UILabel     *_tipsLbl;
    UIImageView *_tipsIcon;
    
    NSTimer     *_hideTimer;
    UIImage     *_tipsIconImage;//提示信息前面的小图片（ICON_WIDTH，ICON_WIDTH）
}

@property (nonatomic, copy) NSString *tipsMessage;

@end



@implementation StatusBarTipsWindow
@synthesize tipsMessage;

+ (StatusBarTipsWindow*)shareTipsWindow
{
    static dispatch_once_t pred = 0;
    __strong static StatusBarTipsWindow * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

- (id)init
{
    CGRect frame = [UIApplication sharedApplication].statusBarFrame;
    
    frame.origin.y-=20;
    self = [super initWithFrame:frame];
    
//    NSLog(@"self.frame==%@",NSStringFromCGRect(self.frame));
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.windowLevel = UIWindowLevelStatusBar + 10;
        self.backgroundColor = [UIColor blackColor];
        
        //初始化的时候图片为空，即没图片
        _tipsIconImage=nil;
        
        //小图片
        _tipsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(IconLeftMargin, 0, ICON_WIDTH, ICON_WIDTH)];
        _tipsIcon.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tipsIcon.backgroundColor = [UIColor clearColor];
        [self addSubview:_tipsIcon];
        
        //提示文本标签
        _tipsLbl = [[UILabel alloc] initWithFrame:self.bounds];
#ifdef NSTextAlignmentRight
        _tipsLbl.textAlignment = NSTextAlignmentLeft;
        _tipsLbl.lineBreakMode = NSLineBreakByTruncatingTail;
#else
        _tipsLbl.textAlignment = 0; // means UITextAlignmentLeft
        _tipsLbl.lineBreakMode = 4; //UILineBreakModeTailTruncation;
#endif
        _tipsLbl.textColor = TipsColor;
        _tipsLbl.font = TipsFont;
        _tipsLbl.backgroundColor = [UIColor blackColor];
        _tipsLbl.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview:_tipsLbl];
        
        //添加旋转监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Notification Handle

- (void)updateOrientation:(NSNotification*)noti
{
    UIInterfaceOrientation newOrientation = [[noti.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    NSLog(@"new orientation: %d", newOrientation);
    
    switch (newOrientation) {
        case UIInterfaceOrientationPortrait:
        {
            self.transform = CGAffineTransformIdentity;
            self.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT);
            
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            // 先转矩阵，坐标系统落在屏幕有右下角，朝上是y，朝左是x
            self.transform = CGAffineTransformMakeRotation(M_PI);
            self.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - HEIGHT / 2);
            self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT);
            
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        {
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
            // 这个时候坐标轴已经转了90°，调整x相当于调节竖向调节，y相当于横向调节
            self.center = CGPointMake(HEIGHT / 2, [UIScreen mainScreen].bounds.size.height / 2);
            self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, HEIGHT);
            
            break;
        }
        case UIInterfaceOrientationLandscapeRight:
        {
            // 先设置transform，在设置位置和大小
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.center = CGPointMake(SCREEN_WIDTH - HEIGHT / 2, SCREEN_HEIGHT / 2);
            self.bounds = CGRectMake(0, 0, SCREEN_HEIGHT, HEIGHT);
            
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark Tips Method

/*
 * @brief show tips message on statusBar
 */
- (void)showTips:(NSString*)tips
{
    if (_hideTimer) {
        [_hideTimer invalidate];
    }
    
    if (_tipsIconImage) { //需要显示图片
        _tipsIcon.frame = CGRectMake(IconLeftMargin, 0, ICON_WIDTH, ICON_WIDTH);
        _tipsIcon.center=CGPointMake(IconLeftMargin+ICON_WIDTH/2.0, 20/2.0);
        _tipsIcon.image = _tipsIconImage;
        _tipsIcon.hidden = NO;
        
        _tipsLbl.frame = CGRectMake(ICON_WIDTH+IconLeftMargin*2, 0, self.bounds.size.width - ICON_WIDTH-IconLeftMargin*2, self.bounds.size.height);
        _tipsLbl.text = tips;
    } else {  //不需要显示图片
        _tipsIcon.image = nil;
        _tipsIcon.hidden = YES;
        
        _tipsLbl.frame = CGRectMake(IconLeftMargin, 0, self.bounds.size.width-IconLeftMargin*2, self.bounds.size.height);
        _tipsLbl.text = tips;
    }

    [self showAnimate];
    
    
}

- (void)showTips:(NSString*)tips hideAfterDelay:(NSInteger)seconds
{
    [self showTips:tips];
    
    _hideTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(hideTips) userInfo:nil repeats:NO];
}

/*
 * @brief show tips icon and message on statusBar
 */
- (void)showTipsWithImage:(UIImage*)tipsIconImage message:(NSString*)message
{
    
    //2015年07月21日17:11:35 add by 胡仕君：增加1个默认图片
    if (tipsIconImage) {
        _tipsIconImage=tipsIconImage;
    }else{
        _tipsIconImage=LoadBundleImageByName(@"common/com_network_status.png");
    }

    [self showTips:message];
}



- (void)showTipsWithImage:(UIImage*)tipsIconImage message:(NSString*)message hideAfterDelay:(NSInteger)seconds
{
    [self showTipsWithImage:tipsIconImage message:message];
    
    _hideTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(hideTips) userInfo:nil repeats:NO];
}

- (void)showTipsWithImageAndMessage:(NSString*)message
{
    _tipsIconImage=LoadBundleImageByName(@"common/com_network_status.png");
    [self showTips:message];
}

- (void)showTipsWithImageAndMessage:(NSString*)message hideAfterDelay:(NSInteger)seconds
{
    [self showTipsWithImageAndMessage:message];
    
    _hideTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(hideTips) userInfo:nil repeats:NO];
}



/*
 * @brief hide tips window
 */
- (void)hideTips
{
//    self.hidden = YES;
    [self hideAnimate];
}

#pragma mark- 显示和隐藏动画
//提示时候的动画
-(void)showAnimate
{
    [UIView animateWithDuration:AnimateDuration animations:^{
        self.frame=CGRectMake(0, 0, kScreen_Width, 20);
    }];
    
    [self makeKeyAndVisible];
}
//隐藏时候的动画
-(void)hideAnimate
{
    [UIView animateWithDuration:AnimateDuration animations:^{
        self.frame=CGRectMake(0, -20, kScreen_Width, 20);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [self resignKeyWindow]; //一定要注销keywindow
    
    //2015-08-24 13:53:03 update by 胡仕君：防止循环引用，故采用通知的方式
    //一定要让app的主window设置为keywindow并可见，否则手势事件接收不到：（非keywindow不能接收手势，但能响应事件）
    //    AppDelegate *dele=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    UIWindow *window =dele.window;
    //    [window makeKeyAndVisible];
    
    [NotificationCenterClass postNotificationName:@"SetKeyWindowAndVisible" object:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 点击消失
    [self hideAnimate];
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//}

@end
