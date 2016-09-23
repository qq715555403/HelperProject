//
//  VersionUpdateHelper.m
//  HelperProject
//
//  Created by hushijun on 15/8/17.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "VersionUpdateHelper.h"

@implementation VersionUpdateHelper


+(VersionUpdateHelper *)sharedInstance
{
    static VersionUpdateHelper *sharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[VersionUpdateHelper alloc] init];
    });
    return sharedService;
}

-(NSString *) dealUpdateInfoWithLog:(NSString *) strLog
{
    //log=“本次更新内容如下：|1、修复部分bug；|2、首页天气限行界面微调；|3、增加自动定位城市的功能。|4、油站查询界面微调|”
    //分割字符串：1.增加定位  |2.联系我们可以直接拨打电话 |3.新增xxx功能
    NSMutableString *mutStr=[NSMutableString string];
    if ([NSString isEmptyOfString:strLog]) {
        strLog=@"";
    }else{
        NSRange range=[strLog rangeOfString:@"|"];
        if (range.location==NSNotFound) {  //没有|  直接显示
            mutStr=[NSMutableString stringWithFormat:@"%@",strLog];
        } else {
            NSArray *arrLog=[strLog componentsSeparatedByString:@"|"];
            for (NSString *strTemp in arrLog) {
                [mutStr appendFormat:@"%@ \n",strTemp];
            }
        }
    }
    
    //NSString *msg=[NSString stringWithFormat:@"%@有新版本，是否升级?",mutStr];
//    NSString *msg=[NSString stringWithFormat:@"%@有新版本，是否升级?",mutStr];
    NSString *msg=[NSString stringWithFormat:@"%@",mutStr];
    return msg;
}

#pragma mark - 检测版本更新网络请求
- (void)checkVersion
{
    //应用程序id
    //NSString *appID=@"898180872";   //乐乐达appid
    //苹果提供的接口返回很多信息  http://itunes.apple.com/lookup?id=898180872
    //NSString *urlString=[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appID];

    NSString *urlString=@"http://wx.leleda.com/class/IosUpdateInterface.php";

    
    [RequestHelperNoAlerClass getWithUrl:urlString param:nil success:^(NSDictionary *results, NSData *data) {
        
//        version="1.0.5"
//        alert=“1”   1-提示 0-不提示
//        forced="1"  1-强制 0-不强制
//        title=@"新版本有重要更新,必须升级后才能使用！";  "有新版本，是否升级?"
//        log=“本次更新内容如下：|1、修复部分bug；|2、首页天气限行界面微调；|3、增加自动定位城市的功能。|4、油站查询界面微调|”
        
        if (results.count>0) {
            NSString *strAlert=results[@"alert"];
//            strAlert=@"1";
            if ([NSString isEmptyOfString:strAlert]==NO) { //必须是非空字符串才进行下面的处理
                if ([strAlert isEqualToString:@"1"]) { //如果是1则提示，如果是0不提示
                    NSString *strForced=results[@"forced"];
                    if ([NSString isEmptyOfString:strForced]) {
                        strForced=@"0";
                    }
                    NSString *strTitle=results[@"title"];
                    
                    NSString *strLog=results[@"log"];
                    //strLog=@"本次更新内容如下：|1、修复部分bug；|2、首页天气限行界面微调；|3、增加自动定位城市的功能。|4、油站查询界面微调|";
                    //strLog=@"本次更新内容如下：1、修复部分bug；2、首页天气限行界面微调；3、增加自动定位城市的功能。4、油站查询界面微调";
                    //处理提示信息
                    NSString *msg=[self dealUpdateInfoWithLog:strLog];
                    
                    //获取客户端安装的app版本号
                    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                    NSString *strVersion=results[@"version"];
                    //                strVersion=@"1.2";
                    NSLog(@"currentVersion==%@,strVersion==%@",currentVersion,strVersion);
                    
//                    strForced=@"1";
                    if ([strForced isEqualToString:@"1"]) { //强制更新
                        isForced=YES;
                        //这个宏可以获取iOS的版本信息，例如5.0.1或者5.1等等
                        if ([strVersion compare:currentVersion] != NSOrderedAscending) {
                            if ([NSString isEmptyOfString:strTitle]) {
                                strTitle=@"新版本有重要更新,必须升级后才能使用！";
                            }
                            //strVersion大于currentVersion
                            [CPToast alertTitle:strTitle andMessage:msg delegate:self btnTitle:@"升级" otherBtnTitles:nil];
                            
                        }else{
                            NSLog(@"强制-没有更新~~");
                        }
                    } else { //不强制更新
                        isForced=NO;
                        //这个宏可以获取iOS的版本信息，例如5.0.1或者5.1等等
                        if ([strVersion compare:currentVersion] != NSOrderedAscending) {
                            if ([NSString isEmptyOfString:strTitle]) {
                                strTitle=@"有新版本，是否升级?";
                            }
                            //strVersion大于currentVersion
                            [CPToast alertTitle:strTitle andMessage:msg delegate:self btnTitle:@"升级" otherBtnTitles:@"取消"];
                        }else{
                            NSLog(@"不强制-没有更新~~");
                        }
                    }//END:[strForced isEqualToString:@"1"]
                }//END:[strAlert isEqualToString:@"1"]
            }//END:[NSString isEmptyOfString:strAlert]==NO
        }//END:results.count>0
    } failure:^(NSDictionary *results, NSError *error) {
        NSLog(@"自动更新接口网络请求失败~~~~");
    }];
}

#pragma mark UIAlertViewDelegate代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"到appstore去更新");
//            self.appUrl=@"https://itunes.apple.com/us/app/le-le-da-shou-ji-wei-xiu-jian/id898180872?mt=8&ign-mpt=uo%3D4";
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appUrl]];
            [self gotoAppstoreUpdate];
            
            if (isForced) {
                //退出
                exit(0);
            }
        }break;
            
        case 1:
        {
            NSLog(@"取消更新");
        }break;
            
        default:{
            
        }break;
    }
}

-(void) gotoAppstoreUpdate
{
    if ([[UIDevice currentDevice] systemVersion].doubleValue >= 7.0) {
        NSString * appstoreUrlString = @"itms-apps://itunes.apple.com/app/id898180872";
        
        NSURL * url = [NSURL URLWithString:appstoreUrlString];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }else{
            NSLog(@"can not open");
        }
    } else{
        NSString * appstoreUrlString = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id=898180872";
        
        NSURL * url = [NSURL URLWithString:appstoreUrlString];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }else{
            NSLog(@"can not open");
        }
    }
}

@end
