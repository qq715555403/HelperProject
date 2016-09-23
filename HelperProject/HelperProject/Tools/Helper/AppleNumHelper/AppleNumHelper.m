//
//  AppleNumHelper.m
//  SerialNumberQuery
//
//  Created by hushijun on 15/7/3.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "AppleNumHelper.h"

@implementation AppleNumHelper


+(AppleNumHelper *)sharedInstance
{
    static AppleNumHelper *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[AppleNumHelper alloc] init];
    });
    
    
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        arrYear=@[@"C",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"V",@"W",@"X",@"Y",@"Z"];
        arrWeak=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"C",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"T",@"V",@"W",@"X",@"Y"];
        
    }

    return self;
}

//获取生产地址
-(NSString *) getProductAddressByKey:(NSString *) keyStr
{
    
    //        F2QJTLYLDTWF:第1-3位代表生产厂家:
    //        C开头——产自中国深圳China,Shenzhen-Foxxcon
    //        D开头——产自中国成都China,Chengdu-Foxconn
    //        F开头——产自中国郑州China,Zhengzhou-Foxconn
    
    NSString *strTemp;
    if ([keyStr isEqualToString:@"C"]) {
        strTemp=@"中国深圳";
    } else if([keyStr isEqualToString:@"D"]){
        strTemp=@"中国成都";
    }else if([keyStr isEqualToString:@"F"]){
        strTemp=@"中国郑州";
    }else{
        strTemp=@"";
    }
    
    return strTemp;
}

-(NSString *) getProductWeakByKey:(NSString *) keyStr
{
    NSString *strResult=nil;
    
    //将key转换为大写
    keyStr=[keyStr uppercaseString];
//    keyStr=@"JT";
    NSLog(@"keyStr==%@",keyStr);
    if ([keyStr trim].length==2) {
        NSString *strYearKey=[keyStr substringToIndex:1];
        NSString *strWeakKey=[keyStr substringFromIndex:1];
        
        NSLog(@"strYearKey===%@,strWeakKey===%@",strYearKey,strWeakKey);
        
        NSString *productYearAndTopOrDown=[self getYearByKey:strYearKey];
        NSString *productYear=[productYearAndTopOrDown substringToIndex:productYearAndTopOrDown.length-1];
        NSString *strTopOrDown=[productYearAndTopOrDown substringFromIndex:productYearAndTopOrDown.length-1];
        
        //?如何获取某一年的第一周开始结束日期:根据某1个日期计算该日期的周开始日期和周结束日期
        NSDate *productYearDate=[NSDate dateFromString:[NSString stringWithFormat:@"%@-01-01",productYear] withFormat:@"yyyy-MM-dd"];
        NSDate *beginDate=[productYearDate beginningOfWeek];
        NSDate *endDate=[productYearDate endOfWeek];
        NSLog(@"productYearDate==%@,beginDate==%@,endDate==%@",productYearDate,beginDate,endDate);
        
        int weakNum;
        if ([strTopOrDown isEqualToString:@"上"]) {
            weakNum=[self getWeakByKey:strWeakKey];
        } else {
            weakNum=[self getWeakByKey:strWeakKey]+26;
        }
        
        NSDate *beginDateByWeakNum=[beginDate dateAfterDay:weakNum*7];
        NSDate *endDateByWeakNum=[endDate dateAfterDay:weakNum*7];
        
        NSString *strBeginDateByWeakNum=[beginDateByWeakNum stringWithFormat:@"yyyy-MM-dd"];
        NSString *strEndDateByWeakNum=[endDateByWeakNum stringWithFormat:@"yyyy-MM-dd"];
        NSLog(@"%@年，第%d周<====>beginDateByWeakNum=%@,endDateByWeakNum==%@",productYear,weakNum,strBeginDateByWeakNum,strEndDateByWeakNum);
        
        strResult=[NSString stringWithFormat:@"%@ ~ %@",strBeginDateByWeakNum,strEndDateByWeakNum];
//        strResult=[NSString stringWithFormat:@"%@年，第%d周==>\n%@ ~ %@",productYear,weakNum+1,strBeginDateByWeakNum,strEndDateByWeakNum];
    }

    return strResult;
}


-(NSString *) getYearByKey:(NSString *) keyStr
{
    NSString *strYear=nil;
    
    if (keyStr.length>0) {
        NSInteger indexOfKey=[arrYear indexOfObject:keyStr];
        
        //年数组索引偶数是上半年，奇数是下半年 ：索引是0表示2010年上半年  2020年下半年
        int intBeginYear=2010; //10年轮回开始年
//        int intEndYear=intBeginYear+9; //10年轮回结束年
        
        //计算生产年份
        int productYear=intBeginYear+(int)indexOfKey/2;
        
        
        NSString *strTopOrDown;
        
        //根据索引奇偶数，计算上半年还是下半年
        if (indexOfKey%2==0) {  //偶数：上半年
            strTopOrDown=@"上";
        }else{ //奇数 下半年
            strTopOrDown=@"下";
        }
        
        
        strYear=[NSString stringWithFormat:@"%d%@",productYear,strTopOrDown];
        
        NSLog(@"strYear==%@",strYear);
        
    }
    
    return strYear;
}

-(int) getWeakByKey:(NSString *) keyStr
{
    int indexOfkey=-1;
    if (keyStr.length>0) {
        indexOfkey=(int)[arrWeak indexOfObject:keyStr];
    }
    return indexOfkey;
}

@end
