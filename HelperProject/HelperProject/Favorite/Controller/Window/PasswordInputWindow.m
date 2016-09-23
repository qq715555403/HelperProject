//
//  PasswordInputWindow.m
//  HelperProject
//
//  Created by hushijun on 15/8/20.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "PasswordInputWindow.h"

@implementation PasswordInputWindow
{
    UITextField *_textField;
    UIView *_bgView;
}

+(PasswordInputWindow *) sharedInstance
{
    static id sharedInstance=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    
    return sharedInstance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor yellowColor];

        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 20)];
        lbl.text=@"请输入密码:";
        [self addSubview:lbl];
        
        _textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 80, 200, 20)];
        _textField.backgroundColor=[UIColor whiteColor];
        _textField.secureTextEntry=YES;
        [self addSubview:_textField];
        
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 110, 200, 44)];
        btn.backgroundColor=[UIColor blueColor];
        btn.titleLabel.textColor=[UIColor blackColor];
        [btn setTitle:@"ok" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)show
{
    [self makeKeyWindow];
    self.hidden=NO;
}

-(void)btnClicked:(UIButton *)btn
{
    if ([_textField.text isEqualToString:@"abcd"]) {
        [_textField resignFirstResponder];

        [UIView animateWithDuration:0.3 animations:^{
//            self.window.transform = CGAffineTransformMakeScale(0.0, 0.0);//缩放
            self.frame=CGRectMake(0, -kScreen_Height, kScreen_Width,kScreen_Height);
        } completion:^(BOOL finished) {
            [self resignKeyWindow];
            self.hidden=YES;
        }];
        
        
    }else{
        [self showErrorAlertView];
    }
}

-(void)showErrorAlertView
{
    [CPToast alertTitle:nil andMessage:@"密码错误哦~正确密码是abcd" delegate:nil btnTitle:@"ok"];
}

@end
