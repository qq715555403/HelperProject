//
//  DeviceViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/14.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "DeviceViewController.h"

@interface DeviceViewController ()

@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO; //隐藏系统tabbar
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES; //隐藏系统tabbar
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)lookBatteryInfo:(id)sender {
    //    If you write a new png to /User/Library/LockBackground.png and then call notify_post(" com.apple.language.changed"); the device will respring and your new background will be present.
    //
    //    This isn't technically a private API, but does fall outside of what Apple allows on the store.
    //
    //    NSData * data = UIImagePNGRepresentation(self.img.image);
    //
    //    NSString *path=[MainBundleClass pathForResource:@"108" ofType:@"png"];
    //    NSLog(@"path==%@",path);
    //
    //
    //    [data writeToFile:@"/User/Library/LockBackground.png" atomically:YES];
    //
    ////    [FileManagerClass copyItemAtPath:path toPath:@"/User/Library/LockBackground.png" error:nil];
    //
    ////    [FileManagerClass createFileAtPath:@"/User/Library/LockBackground.png" contents:data attributes:nil];
    //
    ////    [NotificationCenterClass postNotificationName:@"com.apple.language.changed" object:nil];
    //
    //    notify_post("com.apple.language.changed");
    
    //    If you write a new png to /User/Library/LockBackground.png and then call notify_post(" com.apple.language.changed"); the device will respring and your new background will be present.
    //
    //    This isn't technically a private API, but does fall outside of what Apple allows on the store.
    
    NSMutableString *str=[NSMutableString stringWithString:@"\n电池信息如下:\n"];
    if ([ALBattery batteryFullCharged]) {
        [str appendString:@"1、电池充满电\n"];
        NSLog(@"1、电池充满电");
    }else{
        [str appendString:@"1、电池未充满电\n"];
        NSLog(@"1、电池未充满电");
    }
    
    if ([ALBattery inCharge]) {
        [str appendString:@"2、电池正在充电\n"];
        NSLog(@"2、电池正在充电");
    }else{
        [str appendString:@"2、电池没有充电\n"];
        NSLog(@"2、电池没有充电");
    }
    
    if ([ALBattery devicePluggedIntoPower]) {
        [str appendString:@"3、电池连接电源\n"];
        NSLog(@"3、电池连接电源");
    }else{
        [str appendString:@"3、电池没有连接电源\n"];
        NSLog(@"3、电池没有连接电源");
    }
    
    [str appendFormat:@"4、电池状态：%d\n",(int)[ALBattery batteryState]];
    NSLog(@"4、电池状态：%d",(int)[ALBattery batteryState]);
    
    [str appendFormat:@"5、电池电量：%lf\n",[ALBattery batteryLevel]];
    NSLog(@"5、电池电量：%lf",[ALBattery batteryLevel]);
    
    
    NSLog(@"info==%@",[ALBattery infoForDevice]);
    
    [str appendFormat:@"6、正常：%@\n",[ALBattery remainingHoursForStandby]];
    NSLog(@"6、标准：%@",[ALBattery remainingHoursForStandby]);
    
    [str appendFormat:@"7、3G通话：%@\n",[ALBattery remainingHoursFor3gConversation]];
    NSLog(@"7、3G通话：%@",[ALBattery remainingHoursFor3gConversation]);
    
    [str appendFormat:@"8、2G通话：%@\n",[ALBattery remainingHoursFor2gConversation]];
    NSLog(@"8、2G通话：%@",[ALBattery remainingHoursFor2gConversation]);
    
    [str appendFormat:@"9、3G上网：%@\n",[ALBattery remainingHoursForInternet3g]];
    NSLog(@"9、3G上网：%@",[ALBattery remainingHoursForInternet3g]);
    
    [str appendFormat:@"10、WiFi上网：%@\n",[ALBattery remainingHoursForInternetWiFi]];
    NSLog(@"10、WiFi上网：%@",[ALBattery remainingHoursForInternetWiFi]);
    
    [str appendFormat:@"11、视频播放：%@\n",[ALBattery remainingHoursForVideo]];
    NSLog(@"11、视频播放：%@",[ALBattery remainingHoursForVideo]);
    
    [str appendFormat:@"12、音频播放：%@\n",[ALBattery remainingHoursForAudio]];
    NSLog(@"12、音频播放：%@",[ALBattery remainingHoursForAudio]);
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    
    [str appendFormat:@"13、运行商名称：%@",mCarrier];
    
    NSString *mConnectType = [[NSString alloc] initWithFormat:@"%@",info.currentRadioAccessTechnology];
//    CTRadioAccessTechnologyGPRS
    NSRange range=[mConnectType  rangeOfString:@"CTRadioAccessTechnology"];
    NSString *strTemp=[mConnectType substringFromIndex:range.length];
    [str appendFormat:@"14、网络类型：%@",strTemp];
    
    
    //设备相关信息的获取
    NSString *strName = [[UIDevice currentDevice] name];
    NSLog(@"设备名称：%@", strName);//e.g. "My iPhone"
    
    //    NSString *strId = [[UIDevice currentDevice] uniqueIdentifier];
    //    NSLog(@"设备唯一标识：%@", strId);//UUID,5.0后不可用
    
    NSString *strSysName = [[UIDevice currentDevice] systemName];
    NSLog(@"系统名称：%@", strSysName);// e.g. @"iOS"
    
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"系统版本号：%@", strSysVersion);// e.g. @"4.0"
    
    NSString *strModel = [[UIDevice currentDevice] model];
    NSLog(@"设备模式：%@", strModel);// e.g. @"iPhone", @"iPod touch"
    
    NSString *strLocModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"本地设备模式：%@", strLocModel);// localized version of model //地方型号  （国际化区域名称）
    
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );   //手机型号
    
    
    [str appendFormat:@"\n设备名称：%@\n系统名称：%@\n系统版本号：%@\n设备模式：%@\n设备本地设备模式：%@\n手机型号：%@\n",strName,strSysName,strSysVersion,strModel,strLocModel,phoneModel];
    
    
    [CPToast alertTitle:nil andMessage:str];

    
}
- (IBAction)lookDeviceInfo:(id)sender {
    DeviceInfoViewController *dvc=[[DeviceInfoViewController alloc]init];
    [self.navigationController pushViewController:dvc animated:YES];
}


- (IBAction)setWallPaper:(id)sender {
    //    NSHTTPCookieStorage
    //    NSString *strUrl=@"http://ui.leleda.com/part_app/v2/iphone6p.php?t=iPhone%206&phoneid=22";
    //    NSRange range1=[strUrl rangeOfString:@"?"];
    //    NSRange range2=[strUrl rangeOfString:@"http://ui.leleda.com/part_app/v2/"];
    //
    //
    //    NSString *subStr=[strUrl substringWithRange:NSMakeRange(range2.length, range1.location-range2.length)];
    //    NSLog(@"substr=%@",subStr);
    //    NSRange range3=[subStr rangeOfString:@"."];
    //    NSString *strResult=[subStr substringToIndex:range3.location];
    //    NSLog(@"strResult=%@",strResult);
    
    
    NSString *strUrl=@"http://ui.leleda.com/part_app/v2/iphone6p.php?t=iPhone%206&phoneid=22";
    NSRange range1=[strUrl rangeOfString:@"phoneid="];
    NSString *subStr=[strUrl substringFromIndex:range1.location+range1.length];
    NSLog(@"subStr=%@",subStr);
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
