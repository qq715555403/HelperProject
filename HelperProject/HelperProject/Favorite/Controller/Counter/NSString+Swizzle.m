////
////  NSString+Swizzle.m
////  HelperProject
////
////  Created by hushijun on 15/9/8.
////  Copyright (c) 2015年 hushijun. All rights reserved.
////
//
//#import "NSString+Swizzle.h"
//
//@implementation NSString (Swizzle)
//
////调用的时间比较靠前，适合在这个方法里做方法交换
//+ (void)load{
//    //方法交换应该被保证，在程序中只会执行一次
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self swizzleClassMethod:@selector(resolveInstanceMethod:) withClassMethod:@selector(s_resolveInstanceMethod:)];
//    });
//}
//+ (BOOL) s_resolveInstanceMethod:(SEL) sel
//{
//    NSString *selString = NSStringFromSelector(sel);
//    if ([selString isEqualToString:@"count"] ||
//        [selString isEqualToString:@"objectAtIndex:"] ||
//        [selString isEqualToString:@"makeObjectsPerformSelector:withObject:"]){
//        class_addMethod(self, sel, (IMP)dynamicMethodIMP, "v@:");
//        return YES;
//    }else{
//        return NO;
//    }
//    return YES;
//}
//void dynamicMethodIMP(id self,SEL _cmd)
//{
//    NSLog(@"dynamicMethodIMP");
//}
//
//
//+(BOOL) swizzleClassMethod:(SEL)origSel withClassMethod:(SEL) altSel
//{
//    Class c=object_getClass((id)self);
//    return [c swizzleMethod:origSel wtithMethod:altSel];
//}
//
//+ (BOOL)swizzleMethod:(SEL)origSel wtithMethod:(SEL)altSel {
//    Method originMethod=class_getInstanceMethod(self, origSel);
//    Method newMethod=class_getInstanceMethod(self, altSel);
//    
//    if (originMethod && newMethod) {
//        if (class_addMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
//            class_replaceMethod(self, altSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
//        }else{ //如果class_addMethod失败了，我们就知道了是此类直接实现了正在混写的方法
//            method_exchangeImplementations(originMethod, newMethod);
//        }
//        return YES;
//    }
//    return NO;
//    
//}
//
//@end
