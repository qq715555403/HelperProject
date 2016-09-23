//
//  CustumTextField.m
//  SerialNumberQuery
//
//  Created by hushijun on 15/7/28.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "CustumTextField.h"

@implementation CustumTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*
////控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect
 */
-(void) drawPlaceHolderInRect:(CGRect)rect
{
    [RGBAColor(221, 221, 221, 0.5) setFill];
    [self.placeholder drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
}

@end
