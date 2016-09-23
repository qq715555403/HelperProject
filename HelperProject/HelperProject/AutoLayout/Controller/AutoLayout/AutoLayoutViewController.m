//
//  AutoLayoutViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/25.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "AutoLayoutViewController.h"

@interface AutoLayoutViewController ()

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

//重写宽度约束
-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.myBtn removeConstraint:self.myCon];
    
    NSLayoutConstraint *cons=[NSLayoutConstraint constraintWithItem:self.myBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.1 constant:1];
    
    cons.priority=UILayoutPriorityDefaultHigh;
    
    [self.view addConstraint:cons];
    
    
    
}

////固有大小，label、btn等有固有大小，其他视图固有大小为0
//- (CGSize)intrinsicContentSize
//{
//    
//}

//从子页面返回首页
- (IBAction)unwindSegueToAutoLayoutViewController:(UIStoryboardSegue *)segue
{
    [MobClick event:@"testBuy" attributes:@{@"book" : @"Swift Fundamentals"} counter:110];
}


@end
