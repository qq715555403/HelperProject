//
//  NSString+Extension.h
//  demo
//
//  Created by hushijun on 15/5/22.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
{
//    NSString *_strTest;//类目不能声明实例变量,这里声明就会报错
}

@property(nonatomic,copy) NSString *strTest;//必须手动实现get、set方法，达到1种假象

//类方法
//判断字符串是否为空
+ (BOOL) isEmptyOfString:(NSString *)strTemp;

/*去除字符串左右空格;
 备注：前提必须是非空字符串；在调用此方法前最好判断字符串是否为空，
      如果字符串是空的则根本不会调用nsstring的方法,就会导致bug
 */
-(NSString *) trim;

/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;





@end
