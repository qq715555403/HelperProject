//
//  GradientLayerView.h
//  HelperProject
//
//  Created by hushijun on 15/10/14.
//  Copyright © 2015年 hushijun. All rights reserved.
/*
 渐变效果的view
 
 */

#import <UIKit/UIKit.h>

@interface GradientLayerView : UIView

//为了增加一个标识进度的进行，我们可以使用mask属性来屏蔽一部分，在头文件中添加两个属性：
//@property (nonatomic, readonly) CALayer *maskLayer;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, assign) CGFloat progress;


//- (void)setProgress:(CGFloat)value;

@end
