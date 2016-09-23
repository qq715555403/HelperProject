//
//  CustomKeyboardViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/18.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "CustomKeyboardViewController.h"

@interface CustomKeyboardViewController ()
{
    UIButton *doneButton;
    UIView *view;
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    IBOutlet UILabel *lbl5;
    
    
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation CustomKeyboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    AFFNumericKeyboard *keyboard = [[AFFNumericKeyboard alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
    self.textField.inputView = keyboard;
    keyboard.delegate = self;
    
    
    NSLog(@"self.textField.top==%lf,self.textField.screenX==%lf,self.textField.screenViewX==%lf",lbl5.top,lbl3.screenX,lbl3.screenViewX);
    
    
    /**
     *  备注：使用自定义的inputview接收不到通知
     */
//    [self.textField addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO; //隐藏系统tabbar
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES; //隐藏系统tabbar
}

-(void)textFieldChanged
{
    NSLog(@"textFieldChanged,self.textField.text==|%@|",self.textField.text);
}
-(void)textFieldChanged:(NSNotification *) notiy
{
    NSLog(@"textFieldChanged:(NSNotification *) notiy,self.textField.text==|%@|",self.textField.text);
    
    NSRange range1=[self.textField.text rangeOfString:@"."];
    if (range1.location!=NSNotFound) {
        isPoint=YES;
    }
}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSLog(@"textFieldDidBeginEditing");
//    NSRange range1=[textField.text rangeOfString:@"."];
//    if (range1.location!=NSNotFound) {
//        isPoint=YES;
//    }
//    return YES;
//}


-(void)changeKeyboardType
{
    [self.textField resignFirstResponder];
    self.textField.inputView = nil;
    [self.textField becomeFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
    NSRange range=[textField.text rangeOfString:@"."];
    if (range.location!=NSNotFound) {
        isPoint=YES;
    }
}

-(void)numberKeyboardBackspace
{
    if (self.textField.text.length != 0)
    {
        self.textField.text = [self.textField.text substringToIndex:self.textField.text.length -1];
        NSRange range=[self.textField.text rangeOfString:@"."];
        if (range.location!=NSNotFound) {
            isPoint=YES;
        }else{
            isPoint=NO;
        }
    }
}


-(void)numberKeyboardInput:(NSString *)strInfo
{
    NSRange range=[self.textField.text rangeOfString:@"."];
    if (range.location!=NSNotFound) {
        isPoint=YES;
    }
    
    if ((isPoint && [strInfo isEqualToString:@"."]) || (self.textField.text.length==0 &&[strInfo isEqualToString:@"."] )) {
        
        self.textField.text = [self.textField.text stringByAppendingString:[NSString stringWithFormat:@""]];
    }else{
        self.textField.text = [self.textField.text stringByAppendingString:[NSString stringWithFormat:@"%@",strInfo]];
    }
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = doneButton.frame;
        rect.origin.y += 53*5;
        doneButton.frame = rect;
        
    }];
}


- (void)didReceiveMemoryWarning
{
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

@end
