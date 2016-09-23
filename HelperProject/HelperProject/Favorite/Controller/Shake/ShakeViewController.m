//
//  ShakeViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/18.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "ShakeViewController.h"
#import "LZAudioTool.h"

@interface ShakeViewController ()
@property (nonatomic, weak) UIImageView *bg;
@property (nonatomic, weak) UIImageView *up;
@property (nonatomic, weak) UIImageView *down;
@end

@implementation ShakeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"bg_shaking"];
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    self.bg = bg;
    
    
    UIImageView *up = [[UIImageView alloc] init];
    up.image = [UIImage imageNamed:@"bg_yaoyao_above"];
//    up.frame = CGRectMake(0, 0, self.view.width, self.view.height * 0.5);
    up.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.5);
    [bg addSubview:up];
    self.up = up;
    
    
    UIImageView *down = [[UIImageView alloc] init];
    down.image = [UIImage imageNamed:@"bg_yaoyao_under"];
//    down.frame = CGRectMake(0, self.view.height * 0.5, self.view.width, self.view.height * 0.5);
    down.frame = CGRectMake(0, self.view.frame.size.height * 0.5, self.view.frame.size.width, self.view.frame.size.height * 0.5);
    [bg addSubview:down];
    self.down = down;
}


-(BOOL)canBecomeFirstResponder
{
    return YES;
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self becomeFirstResponder];
    
}


-(void)viewWillDisappear:(BOOL)animated {
    
    [self resignFirstResponder];
    
    [super viewWillDisappear:animated];
    
}

#pragma mark - 实现相应的响应者方法
/** 开始摇一摇 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionBegan");
    
    //CGFloat offset = self.bg.height/2;
    CGFloat offset = 100;

    [UIView animateWithDuration:0.4 animations:^{
        self.up.yValue -= offset;
        self.down.yValue += offset;
    }];
    
    
    [LZAudioTool playMusic:@"dance.mp3"];
}

/** 摇一摇结束（需要在这里处理结束后的代码） */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // 不是摇一摇运动事件
    if (motion != UIEventSubtypeMotionShake) return;
    
    NSLog(@"motionEnded");
    //CGFloat offset = self.bg.height/2;
    CGFloat offset = 100;

    [UIView animateWithDuration:0.4 animations:^{
        self.up.yValue += offset;
        self.down.yValue -= offset;
    }];
    
}

/** 摇一摇取消（被中断，比如突然来电） */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionCancelled");
}

@end
