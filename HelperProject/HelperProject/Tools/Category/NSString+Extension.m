//
//  NSString+Extension.m
//  demo
//
//  Created by hushijun on 15/5/22.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

//@dynamic strTest;

//判断字符串是否为空
+ (BOOL) isEmptyOfString:(NSString *)strTemp
{
    NSLog(@"strTemp==%@",strTemp);
    if (strTemp == nil || strTemp == NULL) { //nil、NULL
        return YES;
    }
    if ([strTemp isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([strTemp isEqual:[NSNull null]]) {  //(null)
        return YES;
    }
    
    if ([[strTemp trim] length]==0) {
        return YES;
    }
    
    return NO;
}
//去除字符串左右空格
+ (NSString *) trimOfString:(NSString *)strTemp
{
    NSString *strType=[strTemp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return strType;
}
/*去除字符串左右空格;
 备注：前提必须是非空字符串；在调用此方法前最好判断字符串是否为空，
 如果字符串是空的则根本不会调用nsstring的方法,就会导致bug
 */
-(NSString *) trim
{
    NSString *strType=[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return strType;
}

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    
}


-(void) setStrTest:(NSString *) str
{
//    _strTest=str;//由于类目不能声明实例变量，所以这里没法实现对属性的成员变量赋值
    NSLog(@"类目中伪属性strTest的set方法。。。");
}

-(NSString *) strTest
{
    NSString *str=@"test字符串";
    NSLog(@"类目中伪属性strTest的get方法。。。");
    return str;
}

@end
