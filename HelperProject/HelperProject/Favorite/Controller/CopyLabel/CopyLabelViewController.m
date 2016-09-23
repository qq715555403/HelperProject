//
//  CopyLabelViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/14.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "CopyLabelViewController.h"

@interface CopyLabelViewController ()

@end

@implementation CopyLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label1.copyableLabelDelegate=self;
    
    
//    设置UITextView光标的颜色
    self.tvTest.tintColor=[UIColor redColor];
    
    NSLog(@"self.label1.top==%lf,self.label1.screenX==%lf,self.label1.screenViewX==%lf，frame==%@",self.label1.top,self.label1.screenX,self.label1.screenViewX,NSStringFromCGRect(self.label1.screenFrame));
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


#pragma mark - HTCopyableLabelDelegate

- (NSString *)stringToCopyForCopyableLabel:(HTCopyableLabel *)copyableLabel
{
    if ([NSString isEmptyOfString:copyableLabel.text]) {
        NSLog(@"标签文本为空~");
    }
    NSString *stringToCopy = self.label1.text;
    return stringToCopy;
}

- (CGRect)copyMenuTargetRectInCopyableLabelCoordinates:(HTCopyableLabel *)copyableLabel
{
    //    CGRect rect;
    //    if (copyableLabel == self.label2
    //        || copyableLabel == self.label3
    //        || copyableLabel == self.label4)
    //    {
    //        // The UIMenuController will appear close to container, indicating all of its contents will be copied
    //        rect = [self.labelContainer1 convertRect:self.labelContainer1.bounds toView:copyableLabel];
    //    }
    //    else if (copyableLabel == self.label5)
    //    {
    //        // The UIMenuController will appear close to the label itself
    //        rect = copyableLabel.bounds;
    //    }
    CGRect rect=copyableLabel.bounds;
    return rect;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
