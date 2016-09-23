//
//  PlantReference.h
//  HelperProject
//
//  Created by hushijun on 15/8/31.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlantReference : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *brief;

@property(nonatomic,assign) NSInteger waterIndex;
@property(nonatomic,assign) NSInteger sumIndex;
@property(nonatomic,assign) NSInteger temperatureIndex;
@property(nonatomic,assign) NSInteger electrolyteIndex;

//-(void) initWith/


@end
