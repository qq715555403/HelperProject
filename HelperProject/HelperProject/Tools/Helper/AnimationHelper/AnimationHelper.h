//
//  AnimationHelper.h
//  AnimationTest
//
//  Created by hushijun on 15/6/30.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *      30多个iOS常用动画-带详细注释  +  进阶动画
 */
/** 使用步骤：
 !  一、导入框架：QuartzCore.framework
 *
 *  二、Example:
 *
 *  Step.1
 *
 *      #import "AnimationHelper.h"
 *
 *  Step.2
 *
 *      [AnimationHelper animationMoveLeft:your view];

 CAAnimation可分为以下四种：
 1.CABasicAnimation
 通过设定起始点，终点，时间，动画会沿着你这设定点进行移动。可以看做特殊的CAKeyFrameAnimation
 2.CAKeyframeAnimation
 Keyframe顾名思义就是关键点的frame，你可以通过设定CALayer的始点、中间关键点、终点的frame，时间，动画会沿你设定的轨迹进行移动
 3.CAAnimationGroup
 Group也就是组合的意思，就是把对这个Layer的所有动画都组合起来。PS：一个layer设定了很多动画，他们都会同时执行，如何按顺序执行我到时候再讲。
 4.CATransition
 这个就是苹果帮开发者封装好的一些动画，

 */


@interface AnimationHelper : NSObject


#pragma mark - Custom Animation-CATransition

/**
 *   @brief 快速构建一个你自定义的动画（CATransition类型的动画）,有以下参数供你设置.
 *
 *   @note  调用系统预置Type需要在调用类引入下句
 *
 *          #import <QuartzCore/QuartzCore.h>
 *
 *   @param type                动画过渡类型
 *   @param subType             动画过渡方向(子类型)
 *   @param duration            动画持续时间
 *   @param timingFunction      动画定时函数属性
 *   @param theView             需要添加动画的view.
 *
 *
 */

+ (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction
                     view:(UIView *)theView;

#pragma mark - Preset Animation

/**
 *  下面是一些常用的动画效果
 */

//一、CATransition
// 显示
+ (void)animationRevealFromBottom:(UIView *)view;
+ (void)animationRevealFromTop:(UIView *)view;
+ (void)animationRevealFromLeft:(UIView *)view;
+ (void)animationRevealFromRight:(UIView *)view;

// 渐隐渐消
+ (void)animationEaseIn:(UIView *)view;
+ (void)animationEaseOut:(UIView *)view;

// push
+ (void)animationPushUp:(UIView *)view;
+ (void)animationPushDown:(UIView *)view;
+ (void)animationPushLeft:(UIView *)view;
+ (void)animationPushRight:(UIView *)view;

// move
+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveLeft:(UIView *)view;
+ (void)animationMoveRight:(UIView *)view;


//二、UIViewAnimation
// 翻转
+ (void)animationFlipFromLeft:(UIView *)view;
+ (void)animationFlipFromRight:(UIView *)view;

// 翻页
+ (void)animationCurlUp:(UIView *)view;
+ (void)animationCurlDown:(UIView *)view;

//三、CABasicAnimation
// 旋转缩放
// 各种旋转缩放效果
+ (void)animationRotateAndScaleEffects:(UIView *)view;
//从中心点逐渐放大到全屏、缩小消失
+ (void)animationScaleBigEffects:(UIView *)view;
+ (void)animationScaleSmallEffects:(UIView *)view;

// 旋转同时缩小放大效果
+ (void)animationRotateAndScaleDownUp:(UIView *)view;



//#pragma mark - Private API
////四、CATransition
///**
// *  下面动画里用到的某些属性在当前API里是不合法的,但是也可以用.
// */
//
//+ (void)animationFlipFromTop:(UIView *)view;
//+ (void)animationFlipFromBottom:(UIView *)view;
//
//+ (void)animationCubeFromLeft:(UIView *)view;
//+ (void)animationCubeFromRight:(UIView *)view;
//+ (void)animationCubeFromTop:(UIView *)view;
//+ (void)animationCubeFromBottom:(UIView *)view;
//
//+ (void)animationSuckEffect:(UIView *)view;
//
//+ (void)animationRippleEffect:(UIView *)view;
//
//+ (void)animationCameraOpen:(UIView *)view;
//+ (void)animationCameraClose:(UIView *)view;


//==========================================>>>>进阶动画<<<<============================================
/**
 CAAnimation可分为以下四种：
 1.CABasicAnimation
    通过设定起始点，终点，时间，动画会沿着你这设定点进行移动。可以看做特殊的CAKeyFrameAnimation
 2.CAKeyframeAnimation
    Keyframe顾名思义就是关键点的frame，你可以通过设定CALayer的始点、中间关键点、终点的frame，时间，动画会沿你设定的轨迹进行移动
 3.CAAnimationGroup
    Group也就是组合的意思，就是把对这个Layer的所有动画都组合起来。PS：一个layer设定了很多动画，他们都会同时执行，如何按顺序执行我到时候再讲。
 4.CATransition
    这个就是苹果帮开发者封装好的一些动画，
 */
+(CABasicAnimation *)opacityForever_Animation:(float)time; //永久闪烁的动画
+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time; //有闪烁次数的动画
+(CABasicAnimation *)moveX:(NSNumber *)x duration:(float)time ; //横向移动
+(CABasicAnimation *)moveY:(NSNumber *)x duration:(float)time ;//纵向移动
+(CABasicAnimation *)movePoint:(CGPoint )point duration:(float) time; //点移动
+(CABasicAnimation *)scaleFrom:(NSNumber *) from to:(NSNumber *) to duration:(float)time repeat:(float)repeatCount; //缩放
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeat:(int)repeatCount; //旋转
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry duration:(float)time repeat:(float)repeatCount; //组合动画
+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time repeat:(float)repeatCount; //路径动画

@end
