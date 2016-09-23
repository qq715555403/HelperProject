//
//  UIView+LZ.m
//  
//
//  Created by teacher on 14-6-6.
//  Copyright (c) 2014年 帶頭二哥. All rights reserved.
//

#import "UIView+LZ.h"

@implementation UIView (LZ)


- (void)setXValue:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)xValue
{
    return self.frame.origin.x;
}

- (void)setYValue:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)yValue
{
    return self.frame.origin.y;
}

- (void)setWidthValue:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)widthValue
{
    return self.frame.size.width;
}

- (void)setHeightValue:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)heightValue
{
    return self.frame.size.height;
}

@end
