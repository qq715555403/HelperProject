//
//  TestProtocolProperty.h
//  HelperProject
//
//  Created by hushijun on 15/9/2.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

//7. @protocol 和 category 中如何使用 @property
//
//1）在protocol中使用property只会生成setter和getter方法声明,我们使用属性的目的,是希望遵守我协议的对象能实现该属性
//
//2）category 使用 @property 也是只会生成setter和getter方法的声明,如果我们真的需要给category增加属性的实现,需要借助于运行时的两个函数：
//
//①objc_setAssociatedObject
//
//②objc_getAssociatedObject


#import <Foundation/Foundation.h>

@protocol TestProtocolProperty <NSObject>

@property(nonatomic,copy) NSString *strTest;

- (void) btnCanceled:(NSString *) str;

@end
