//
//  CounterViewController.h
//  HelperProject
//
//  Created by hushijun on 15/8/31.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlantReference.h"

//runtime练习：必须导入此库
#import <objc/runtime.h>
//#import "UIViewController+swizzling.h"
#import "NSString+Swizzle.h"


//typedef enum{
//    PlantReferenceWaterIndex=1,
//    PlantReferenceSumIndex,
//    PlantReferenceTemperatureIndex,
//    PlantReferenceElectrolyteIndex
//} PlantReferenceIndex;

//推荐使用这种方式定义enum，并且不能使用下划线的方式命名，采用驼峰命名法
typedef NS_ENUM(int, PlantReferenceIndex)
{
    PlantReferenceWaterIndex=1,
    PlantReferenceSumIndex,
    PlantReferenceTemperatureIndex,
    PlantReferenceElectrolyteIndex
};


@interface CounterViewController : TotalBaseViewController
{
    UILabel *_displayNum;
    PlantReference *_reference;
}
@end
