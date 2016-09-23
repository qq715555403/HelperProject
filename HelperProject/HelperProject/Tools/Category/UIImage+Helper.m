//
//  UIImage+Helper.m
//  demo
//
//  Created by hushijun on 15/4/7.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

+ (UIImage *)imageForBundleByName:(NSString *)name
{
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"default" ofType:@"bundle"];
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:name];
    
    UIImage *image = nil;
    if (imagePath != nil) {
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    return image;
}

@end
