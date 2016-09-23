//
//  GradientLayerView.m
//  HelperProject
//
//  Created by hushijun on 15/10/14.
//  Copyright © 2015年 hushijun. All rights reserved.
//

#import "GradientLayerView.h"

@implementation GradientLayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Use a horizontal gradient
        CAGradientLayer *layer = (id)[self layer];
        [layer setStartPoint:CGPointMake(0.0, 0.5)];
        [layer setEndPoint:CGPointMake(1.0, 0.5)];
        
        // Create colors using hues in +5 increments
        NSMutableArray *colors = [NSMutableArray array];
        for (NSInteger hue = 0; hue <= 360; hue += 5) {
            
            UIColor *color;
            color = [UIColor colorWithHue:1.0 * hue / 360.0
                               saturation:1.0
                               brightness:1.0
                                    alpha:1.0];
            [colors addObject:(id)[color CGColor]]; 
        } 
        [layer setColors:[NSArray arrayWithArray:colors]];
        
//        //创建一个宽度为0的mask覆盖整个View，mask的颜色不重要，
//        self.maskLayer = [CALayer layer];
//        [self.maskLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
//        [self.maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
//        [layer setMask:self.maskLayer];
        
        [self performAnimation];
        
        
//        [self setProgress:0.7];

    }
    return self;
}

- (void)performAnimation {
    // Move the last color in the array to the front
    // shifting all the other colors.
    CAGradientLayer *layer = (id)[self layer];
    NSMutableArray *mutable = [[layer colors] mutableCopy];
    id lastColor = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:lastColor atIndex:0];
    NSArray *shiftedColors = [NSArray arrayWithArray:mutable];
    
    // Update the colors on the model layer
    [layer setColors:shiftedColors];
    
    // Create an animation to slowly move the gradient left to right.
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:shiftedColors];
    [animation setDuration:0.08];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    [self performAnimation];
} 


//当我们progress属性更新的时候我们会增加它的宽度，所以复写setProgress:方法像下面这样：
- (void)setProgress:(CGFloat)value {
    if (self.progress != value) {
        // Progress values go from 0.0 to 1.0
        self.progress = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}

//现在当我们设置progress值的时候我们要确保它在0到1之间，然后下一步在layoutSubviews里面我们重新定义mask的值。
- (void)layoutSubviews {
    // Resize our mask layer based on the current progress
    CGRect maskRect = [self.maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * self.progress;
    [self.maskLayer setFrame:maskRect];
}

@end
