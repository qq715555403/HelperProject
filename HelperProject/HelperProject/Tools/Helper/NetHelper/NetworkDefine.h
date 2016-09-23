//
//  NetworkDefine.h
//  CNPC_ICCard_iPhone
//
//  Created by hushijun on 15/1/16.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "AFNetworking.h"                //AFN网络请求帮助类
#import "StatusBarTipsWindow.h"

/****************************************各个模块的接口url************************************************/
#pragma mark - =============各个模块的接口url=============

//#define Main_Domain_Url @"http://125.32.26.14"

//网络请求接口域名
#define Main_Domain_Url @"http://wx.leleda.com"

//首页***************************
//天气：
#define WeatherUrl @"http://www.weather.com.cn/data/cityinfo/101010100.html"

//匹配本地html文件和服务器上对应的html文件的MD5值：
#define UrlMD5 @""
#define UrlYijianFankui @"/wapios/recv/CreateFeedback.php"

/****************************************各个模块的url************************************************/


//请求类型
typedef enum{
    RequestTypeMD5,                  //匹配MD5
    RequestTypeYijianFankui          //意见反馈
} RequestType;


//自定义请求错误类型
enum RequestErrorCode {
    RequestErrorOk = 0,             ///< 正确，无错误
    RequestErrorNotNetwork1 = 8887,	///< 没有网络1:reach检测无网络
    RequestErrorNotNetwork = 8888,	///< 没有网络 :afn检测无网络
    RequestErrorUrlEmpty = 8889     ///< url为空
};

//#define Main_Domain @"Main_Domain"
//网络状态改变通知
#define NetWorkChangedNotify  @"netWorkChanged"
#define NetErrorInfo          @"无法连接到网络,请稍后再试"
#define NetAletInfoNoResult   @"离线查询无结果"
#define NetAletInfoOffLine    @"亲，网络不给力，为您开启离线查询模式~"

//#define NetErrorInfo  @""









