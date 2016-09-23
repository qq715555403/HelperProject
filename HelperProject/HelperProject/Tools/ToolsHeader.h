//
//  ToolsHeader.h
//  SerialNumberQuery
//
//  Created by hushijun on 15/7/28.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#ifndef SerialNumberQuery_ToolsHeader_h
#define SerialNumberQuery_ToolsHeader_h


#endif


#ifdef __OBJC__

/*
 * 说明：
 *  1、将tools文件夹导入项目
 *  2、将ToolsHeader.h导入pch文件中
 *  3、导入相关类库的框架：
 *  4、对非arc头文件设置属性：-fno-objc-arc
 **/

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS


/*************************IOS类库中第3方帮助类**************************/
#import "RegexKitLite.h"               //正则表达式
#import "WebViewJavascriptBridge.h"    //js网页交互帮助类
#import <ShareSDK/ShareSDK.h>          //分享sdk

#import "UIImageView+WebCache.h"       //sdwebimage
#import "Masonry.h"                    //自动布局第3方库

#import <AlipaySDK/AlipaySDK.h>        //支付宝支付sdk
#import "WXApi.h"                      //微信支付sdk
#import "WXApiObject.h"                //微信支付sdk
#import "payRequsestHandler.h"         //微信支付帮助类
#import "CMachineKeyStore.h"           //设备uuid帮助类
#import "MobClick.h"                   //友盟统计数据sdk

/*************************IOS类库中类目帮助类**************************/
#import "NSDate-Helper.h"               //日期相关类目帮助类
#import "NSString+Extension.h"          //字符串相关类目帮助类
#import "UITextField+Extension.h"       //UITextField相关类目帮助类
#import "UIImage+Helper.h"              //UIImage相关类目帮助类
#import "UIWebView+Clean.h"             //UIWebView相关类目帮助类
#import "UIView+LZ.h"                   //UIView相关类目帮助类
#import "UIViewAdditions.h"             //UIView相关类目帮助类

/*************************常用操作帮助类**************************/
#import "CPToast.h"                     //提示信息帮助类
#import "DBHelper.h"                    //数据库操作相关帮助类
#import "ALBattery.h"                   //ios设备硬件数据帮助类:电池帮助类中又导入了硬件帮助类（ALHardware.h）
#import "RequestHelper.h"               //自定义网络状态请求帮助类：移到RequestHelper.h中，统一管理网络请求操作
#import "VersionUpdateHelper.h"         //版本更新helper
#import "ASDepthModalViewController.h"  //弹窗视图帮助类
#import "LZAudioTool.h"                 //音频播放帮助类
#import "CustumTextField.h"             //自定义textfield帮助类
#import "HTCopyableLabel.h"             //可复制标签帮助类
#import "NJKWebViewProgress.h"          //webview进度条帮助类
#import "AnimationHelper.h"             //动画帮助类
#import "AppleNumHelper.h"              //苹果序列号帮助类
#import "AFFNumericKeyboard.h"          //自定义数字键盘帮助类
#import "ShareHelper.h" //分享帮助类
/*************************宏定义和基类帮助类**************************/
#import "CommonDefine.h"                //常用宏定义帮助类
#import "TotalBaseViewController.h"     //所有vc的基类
#import "BaseWebViewController.h"       //所有webviewvc的基类


/*************************硬件信息类库帮助类**************************/
//#import "UIDevice-Capabilities.h"
//#import "UIDevice-Hardware.h"
//#import "UIDevice-IOKitExtensions.h"
//#import "UIDevice-Reachability.h"



#endif