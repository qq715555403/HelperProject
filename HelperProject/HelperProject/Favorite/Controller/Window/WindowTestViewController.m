//
//  WindowTestViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/20.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "WindowTestViewController.h"

@interface WindowTestViewController ()

@end

@implementation WindowTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(50, 100, 200, 40);
    [btn setTitle:@"点我创建window" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)btnCliked:(UIButton *) btn
{
    _uiwindow=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _uiwindow.rootViewController=[UIViewController new];
    _uiwindow.windowLevel=2001; //statusbar：1000，alert：2000
    _uiwindow.backgroundColor=[UIColor redColor];
    _uiwindow.hidden=NO;
    
//    UIGestureRecognizer *gesture=[[UIGestureRecognizer alloc]init];
//    [gesture addTarget:self action:@selector(hideWindow:)];
//    [_uiwindow addGestureRecognizer:gesture];

    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]init];
    gesture.numberOfTapsRequired=1;
    [gesture addTarget:self action:@selector(hideWindow:)];
    [_uiwindow addGestureRecognizer:gesture];
    
    
    [CPToast alertTitle:@"弹出alert" andMessage:nil];
}
- (void)hideWindow:(UIGestureRecognizer *)gesture
{
    _uiwindow.hidden=YES;
    _uiwindow=nil;
}


@end
