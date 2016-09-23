//
//  DBHelper.m
//  demo
//
//  Created by hushijun on 15/7/6.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper

+(DBHelper *)sharedInstance
{
    static DBHelper *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[DBHelper alloc] init];
    });
    
    return sharedManager;
}


#pragma mark - 查询数据库获取设备相关信息
-(NSMutableArray *) getDeviceInfoByXLHString:(NSString *) keyStr
{
    keyStr=[keyStr uppercaseString];
    NSMutableArray *mutArryInfo=[NSMutableArray array];
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"xlhdb.sqlite"];
//    DLog(@"数据库地址:%@",sqlPath);
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"xlhdb" ofType:@"sqlite"];
//    DLog(@"原始地址:%@",orignFilePath);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:sqlPath] == NO)//如果doc下没有数据库，从bundle里面拷贝过来
    {
        NSError *err = nil;
        if([fm copyItemAtPath:orignFilePath toPath:sqlPath error:&err] == NO)//如果拷贝失败
        {
            DLog(@"open database error %@",[err localizedDescription]);
        }
        
        DLog(@"document 下没有数据库文件，执行拷贝工作");
    }
    //初始化数据库
    FMDatabase *db=[FMDatabase databaseWithPath:sqlPath];
    //这个方法一定要执行
    if (![db open]) {
        DLog(@"数据库打开失败！");
    }
    
    //查找遍历数据库，
    FMResultSet *rs=[db executeQuery:@"select phoneType,phoneColor,capacity,desc from xlhtbl where xlhKey=?",keyStr];

    while ([rs next]) {
        DeviceModel *dm=[[DeviceModel alloc]init];
        dm.phoneType=[rs stringForColumn:@"phoneType"];
        dm.phoneColor=[rs stringForColumn:@"phoneColor"];
        dm.capacity=[rs stringForColumn:@"capacity"];
        dm.desc=[rs stringForColumn:@"desc"];

        [mutArryInfo addObject:dm];
    }
    [db close];
    
    return mutArryInfo;
}


@end
