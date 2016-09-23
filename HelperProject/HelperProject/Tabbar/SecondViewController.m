//
//  SecondViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/8.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    //    缩小整个view，实现整个屏幕vc都有一条黑边缘的感觉
//    UIView *view=[[UIView alloc]initWithFrame:self.view.bounds];
//    view.backgroundColor=[UIColor blackColor];
//    [self.view addSubview:view];
//
//    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, self.view.frame.size.height-140)];
//    view2.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:view2];
//
//
//    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-140, self.view.frame.size.width, 40)];
//    view3.backgroundColor=[UIColor redColor];
//    [self.view addSubview:view3];
//
//
//    view2.transform=CGAffineTransformMakeScale(0.9, 0.9);
    
    
    UIProgressView *_progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, 80, kScreen_Width,4)];
    _progressView.transform = CGAffineTransformMakeScale(1.0f,1.5f);
//    _progressView.progressViewStyle=UIProgressViewStyleBar;
    _progressView.progressTintColor=RGBAColor(15, 174, 110, 1);
    _progressView.progress=0.5;
    //    _progressView.trackTintColor=[UIColor redColor];
    [self.view addSubview:_progressView];
    
    
    GradientLayerView *gradientView=[[GradientLayerView alloc]initWithFrame:CGRectMake(10, 100, 300, 10)];
    [self.view addSubview:gradientView];
    
    
    UIButton *recoveryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recoveryBtn.frame = CGRectMake(100,150,100,40);
    [self.view addSubview:recoveryBtn];
    [recoveryBtn setTitle:@"测试点击选中" forState:UIControlStateNormal];
    recoveryBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [recoveryBtn setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [recoveryBtn setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateHighlighted];
    [recoveryBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [recoveryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
