//
//  UIView+TestRuntime.m
//  HelperProject
//
//  Created by hushijun on 15/9/8.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "UIView+TestRuntime.h"

@implementation UIView (TestRuntime)

+ (void) printIvarList
{
    u_int count;
    Ivar *ivarList = class_copyIvarList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        const char *ivarName = ivar_getName(ivarList[i]);
        NSString *strName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSLog(@"ivar %@",strName);
    }
}
+ (void) printPropertyList
{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *strName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"Property %@",strName);
    }
}

+ (void) printProtocolList
{
    u_int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        const char * protocolName = protocol_getName(protocolList[i]);
        NSString *strName = [NSString stringWithCString:protocolName encoding:NSUTF8StringEncoding];
        NSLog(@"Protocol %@",strName);
    }
}

+ (void) printMethodList
{
    u_int count;
    Method *methods = class_copyMethodList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"method %@",strName);
    }
}




- (void) runtimeTest
{
    //    unsigned int count;
    //    //获取属性列表
    //    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    //    for (unsigned int i=0; i%@", [NSString stringWithUTF8String:propertyName]);
    //
    //    }
    //     //获取方法列表
    //     Method *methodList = class_copyMethodList([self class], &count);
    //     for (unsigned int i; i%@", NSStringFromSelector(method_getName(method)));
    //
    //     }
    //    //获取成员变量列表
    //    Ivar *ivarList = class_copyIvarList([self class], &count);
    //    for (unsigned int i; i%@", [NSString stringWithUTF8String:ivarName]);
    //
    //    }
    //    //获取协议列表
    //    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    //    for (unsigned int i; i%@", [NSString stringWithUTF8String:protocolName]);
    //         
    //    }
    
    u_int count;
    Ivar *ivarList = class_copyIvarList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        const char *ivarName = ivar_getName(ivarList[i]);
        NSString *strName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSLog(@"ivar %@",strName);
    }
    
//    u_int count;
    objc_property_t *properties = class_copyPropertyList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *strName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"Property %@",strName);
    }
    
//    u_int count;
    Method *methods = class_copyMethodList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"method %@",strName);
    }
    
//    u_int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        const char * protocolName = protocol_getName(protocolList[i]);
        NSString *strName = [NSString stringWithCString:protocolName encoding:NSUTF8StringEncoding];
        NSLog(@"Protocol %@",strName);
    }
}


@end
