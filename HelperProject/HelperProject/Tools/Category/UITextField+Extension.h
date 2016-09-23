//
//  UITextField+Extension.h
//  SerialNumberQuery
//
//  Created by hushijun on 15/7/28.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)


//UITextField实现左侧空出一定的边距
//就是通过uitextfield的leftview来实现的，同时要设置leftviewmode。
//如果设置左右边距，需要再加上rightView功能
-(void)setTextFieldLeftPaddingForWidth:(CGFloat)leftWidth;

-(void)setTextFieldRightPaddingForWidth:(CGFloat)rightWidth;
@end
