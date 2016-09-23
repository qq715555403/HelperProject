//
//  DBHelper.h
//  demo
//
//  Created by hushijun on 15/7/6.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "DeviceModel.h"

@interface DBHelper : NSObject

+(DBHelper *)sharedInstance;

#pragma mark - 查询数据库获取设备相关信息
-(NSMutableArray *) getDeviceInfoByXLHString:(NSString *) keyStr;


@end
