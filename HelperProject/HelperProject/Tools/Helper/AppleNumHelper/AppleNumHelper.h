//
//  AppleNumHelper.h
//  SerialNumberQuery
//
//  Created by hushijun on 15/7/3.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppleNumHelper : NSObject
{
//    用20个字母表示的（26个字母中除去A，B，E，I，O，U），注意是以每半年一进位，如G代表2011年后半年，H代表2012年前半年。每10年1循环
    NSArray *arrYear; //年数组：20个元素
//    用数字（1-9，除去0）和字母（26个字母中除去A，B，E，I，O，U，S，Z）来表示的，共27个，代表周数，从1开始，数完数字数字母，每半年一循环。
    NSArray *arrWeak; //周数组：27个元素
}

+(AppleNumHelper *)sharedInstance;

//获取生产日期
-(NSString *) getProductWeakByKey:(NSString *) keyStr;

//获取生产地址
-(NSString *) getProductAddressByKey:(NSString *) keyStr;

@end
