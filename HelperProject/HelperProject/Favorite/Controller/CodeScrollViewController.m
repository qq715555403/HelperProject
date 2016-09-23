//
//  CodeScrollViewController.m
//  HelperProject
//
//  Created by hushijun on 15/10/10.
//  Copyright © 2015年 hushijun. All rights reserved.
//

#import "CodeScrollViewController.h"

@interface CodeScrollViewController ()

@end

@implementation CodeScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //自己写的代码
    [self createScrollView];
    
    //官方代码
//    [self generateContent];
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

- (void) createScrollView
{
    //scrollview
    self.myScroll=[[UIScrollView alloc]init];
    [self.view addSubview:self.myScroll];
    
//    UIEdgeInsets padding=UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.myScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
//        make.edges.equalTo(self.view).width.insets(padding); 与上面的等效
    }];
    
    //contentView
    UIView *contentView=[[UIView alloc]init];
    [self.myScroll addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(self.view).insets(padding);
        make.edges.equalTo(self.myScroll);
        make.width.equalTo(self.myScroll);//设置等宽，垂直滚动；设置等高，水平滚动
    }];
    
    UIView *lastView;
    CGFloat height=100;
    
    for (NSInteger i = 0; i<15; i++) {
        UIView *viewTemp=[[UIView alloc]init];
        viewTemp.backgroundColor=[self randomColor];
        [contentView addSubview:viewTemp];
        
        [viewTemp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView ? lastView.mas_bottom : @0);
//            make.left.right.equalTo(contentView);
            make.left.equalTo(@0);
            
            //宽度和高度必须定死
            make.width.equalTo(contentView.mas_width);
            make.height.equalTo(@(height));
        }];
        
        lastView = viewTemp;
    }
    
    //在添加子视图之前设置edges，添加完子视图之后，最后一个view的bottom等于contentView的bottom
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}


- (void)generateContent {
    //scrollview
    self.scrollView=[[UIScrollView alloc]init];
    self.scrollView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:self.scrollView];
    
    //    UIEdgeInsets padding=UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        //        make.edges.equalTo(self.view).width.insets(padding); 与上面的等效
    }];
    
    
    //自动布局中，scrollview必须加上1个contentview才能实现自动布局
    UIView* contentView = UIView.new;
    contentView.backgroundColor=[UIColor yellowColor];
    [self.scrollView addSubview:contentView];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
//        make.height.equalTo(self.scrollView);
    }];
    
    UIView *lastView;
    CGFloat height = 125;
    
    for (int i = 0; i < 10; i++) {
        UIView *view = UIView.new;
        view.backgroundColor = [self randomColor];
        [contentView addSubview:view];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [view addGestureRecognizer:singleTap];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView ? lastView.mas_bottom : @0);
            make.left.equalTo(@0);
            
            //make.width.equalTo(contentView.width); 为什么之前直接width没问题呢？
            make.width.equalTo(contentView.mas_width);
            make.height.equalTo(@(height));
        }];
        
        //        height += 25;
        lastView = view;
    }
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}


//随机颜色
- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


- (void)singleTap:(UITapGestureRecognizer*)sender {
    [sender.view setAlpha:sender.view.alpha / 1.20]; // To see something happen on screen when you tap :O
    [self.myScroll scrollRectToVisible:sender.view.frame animated:YES];
};


@end
