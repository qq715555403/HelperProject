//
//  CopyLabelViewController.h
//  HelperProject
//
//  Created by hushijun on 15/8/14.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CopyLabelViewController : UIViewController<HTCopyableLabelDelegate>

@property (strong, nonatomic) IBOutlet UITextField *tfTest;
@property (strong, nonatomic) IBOutlet UIView *tvTest;
@property (nonatomic, weak) IBOutlet HTCopyableLabel  *label1;

@end
