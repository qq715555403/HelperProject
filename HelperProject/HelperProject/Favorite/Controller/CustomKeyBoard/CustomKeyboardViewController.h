//
//  CustomKeyboardViewController.h
//  HelperProject
//
//  Created by hushijun on 15/8/18.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFFNumericKeyboard.h"
@interface CustomKeyboardViewController : UIViewController<AFFNumericKeyboardDelegate,UITextFieldDelegate>
{
    BOOL isPoint;
}

@end
