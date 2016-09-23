//
//  Book.h
//  HelperProject
//
//  Created by hushijun on 15/9/1.
//  Copyright (c) 2015年 hushijun. All rights reserved.
/*
 此类是用于验证@dynamic的
 
 同时runtime相关练习参照如下vc：
 CounterViewController
 
 */

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "TestProtocolProperty.h"

@interface Book : NSObject<TestProtocolProperty>
{
    
@private
    __strong NSString *_name;
    __strong NSString *_author;
    
    
    NSMutableDictionary *_propertiesDict;
    
}
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *author;
@property(nonatomic, copy) NSString *version;

@property(nonatomic, copy) NSString * var;


@end
