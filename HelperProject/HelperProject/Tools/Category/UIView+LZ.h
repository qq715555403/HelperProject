//
//  UIView+LZ.h
//  访问uiview的属性，宽、高、x、y坐标
//
//  Created by 胡仕君 on 14-6-6.
//  Copyright (c) 2014年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LZ)

//2015-08-31 15:58:45 update by：胡仕君：防止和Masonry中的width、height冲突，故增加value加以区别
@property (nonatomic, assign) CGFloat xValue;
@property (nonatomic, assign) CGFloat yValue;
@property (nonatomic, assign) CGFloat widthValue;
@property (nonatomic, assign) CGFloat heightValue;

@end
