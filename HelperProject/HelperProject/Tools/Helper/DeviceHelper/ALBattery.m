//
//  ALBattery.m
//  ALSystem
//
//  Created by Andrea Mario Lufino on 18/07/13.
//  Copyright (c) 2013 Andrea Mario Lufino. All rights reserved.
//

#import "ALBattery.h"

@interface ALBattery ()

+ (UIDevice *)device;
+ (NSDictionary *)infoForDevice;

@end

@implementation ALBattery

#pragma mark - UIDevice

+ (UIDevice *)device {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [UIDevice currentDevice];
}

#pragma mark - Info for device

+ (NSDictionary *)infoForDevice {
    NSString *device = [ALHardware platformType];
//    device=@"iPhone 1";
    
//    NSString *rosourceName=[device stringByReplacingOccurrencesOfString:@" " withString:@""];
////    NSLog(@"rosourceName==%@",rosourceName);
//    NSString *path=[[NSBundle mainBundle] pathForResource:rosourceName ofType:@"plist"];
//    NSDictionary *info = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    
    //    NSLog(@"rosourceName==%@",rosourceName);
    NSString *path=[[NSBundle mainBundle] pathForResource:@"DeviceInfo" ofType:@"plist"];
    NSDictionary *info = [[NSDictionary alloc] initWithContentsOfFile:path];
    
//    NSLog(@"info==%@",info);
    
    NSDictionary *dicResult=nil;
    if (info && info.count>0) {
        NSString *resourceName=[device stringByReplacingOccurrencesOfString:@" " withString:@""];
        dicResult=[info objectForKey:resourceName];
    } else {
        dicResult=nil;
    }
//    NSLog(@"dicResult==%@",dicResult);
    
    return dicResult;
}

#pragma mark - Battery methods

+ (BOOL)batteryFullCharged {
    if ([self batteryLevel] == 100.00) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)inCharge {
    if ([self device].batteryState == UIDeviceBatteryStateCharging ||
        [self device].batteryState == UIDeviceBatteryStateFull) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)devicePluggedIntoPower {
    if ([self device].batteryState == UIDeviceBatteryStateUnplugged) {
        return NO;
    } else {
        return YES;
    }
}

+ (UIDeviceBatteryState)batteryState {
    return [self device].batteryState;
}

+ (CGFloat)batteryLevel {
    CGFloat batteryLevel = 0.0f;
    CGFloat batteryCharge = [self device].batteryLevel;
    if (batteryCharge > 0.0f)
        batteryLevel = batteryCharge * 100;
    else
        // Unable to find battery level
        return -1;
    
    return batteryLevel;
}

+ (NSString *)remainingHoursForStandby {
    CGFloat batteryLevel = [self batteryLevel];
    NSDictionary *info = [self infoForDevice];
    NSInteger maxHours = 0;
    if ([info objectForKey:@"standby"]) {
        maxHours = [[info objectForKey:@"standby"] integerValue];
        CGFloat totMinutes = (maxHours - ((100 - batteryLevel) * maxHours / 100)) * 60; //remaining time in minutes
        NSInteger hours = totMinutes / 60; //get hours
        NSInteger minutes = totMinutes - (hours * 60); // get minutes
        if (hours < 0 || minutes < 0) {
            return [NSString stringWithFormat:@"ND"];
        }
        return [NSString stringWithFormat:@"%i小时%02i分钟",hours,minutes];
    } else
        return @"NS";
}

+ (NSString *)remainingHoursFor3gConversation {
    CGFloat batteryLevel = [self batteryLevel];
    NSDictionary *info = [self infoForDevice];
    NSInteger maxHours = 0;
    if ([info objectForKey:@"standby"]) {
        maxHours = [[info objectForKey:@"conversation3g"] integerValue];
        CGFloat totMinutes = (maxHours - ((100 - batteryLevel) * maxHours / 100)) * 60; //remaining time in minutes
        NSInteger hours = totMinutes / 60; //get hours
        NSInteger minutes = totMinutes - (hours * 60); // get minutes
        if (hours < 0 || minutes < 0) {
            return [NSString stringWithFormat:@"ND"];
        }
        return [NSString stringWithFormat:@"%i小时%02i分钟",hours,minutes];
    } else
        return @"NS";
}

+ (NSString *)remainingHoursFor2gConversation {
    CGFloat batteryLevel = [self batteryLevel];
    NSDictionary *info = [self infoForDevice];
    NSInteger maxHours = 0;
    if ([info objectForKey:@"standby"]) {
        maxHours = [[info objectForKey:@"conversation2g"] integerValue];
        CGFloat totMinutes = (maxHours - ((100 - batteryLevel) * maxHours / 100)) * 60; //remaining time in minutes
        NSInteger hours = totMinutes / 60; //get hours
        NSInteger minutes = totMinutes - (hours * 60); // get minutes
        if (hours < 0 || minutes < 0) {
            return [NSString stringWithFormat:@"ND"];
        }
        return [NSString stringWithFormat:@"%i小时%02i分钟",hours,minutes];
    } else
        return @"NS";
}

+ (NSString *)remainingHoursForInternet3g {
    CGFloat batteryLevel = [self batteryLevel];
    NSDictionary *info = [self infoForDevice];
    NSInteger maxHours = 0;
    if ([info objectForKey:@"standby"]) {
        maxHours = [[info objectForKey:@"internet3g"] integerValue];
        CGFloat totMinutes = (maxHours - ((100 - batteryLevel) * maxHours / 100)) * 60; //remaining time in minutes
        NSInteger hours = totMinutes / 60; //get hours
        NSInteger minutes = totMinutes - (hours * 60); // get minutes
        if (hours < 0 || minutes < 0) {
            return [NSString stringWithFormat:@"ND"];
        }
        return [NSString stringWithFormat:@"%i小时%02i分钟",hours,minutes];
    } else
        return @"NS";
}

+ (NSString *)remainingHoursForInternetWiFi {
    CGFloat batteryLevel = [self batteryLevel];
    NSDictionary *info = [self infoForDevice];
    NSInteger maxHours = 0;
    if ([info objectForKey:@"standby"]) {
        maxHours = [[info objectForKey:@"internetwifi"] integerValue];
        CGFloat totMinutes = (maxHours - ((100 - batteryLevel) * maxHours / 100)) * 60; //remaining time in minutes
        NSInteger hours = totMinutes / 60; //get hours
        NSInteger minutes = totMinutes - (hours * 60); // get minutes
        if (hours < 0 || minutes < 0) {
            return [NSString stringWithFormat:@"ND"];
        }
        return [NSString stringWithFormat:@"%i小时%02i分钟",hours,minutes];
    } else
        return @"NS";
}

+ (NSString *)remainingHoursForVideo {
    CGFloat batteryLevel = [self batteryLevel];
    NSDictionary *info = [self infoForDevice];
    NSInteger maxHours = 0;
    if ([info objectForKey:@"standby"]) {
        maxHours = [[info objectForKey:@"video"] integerValue];
        CGFloat totMinutes = (maxHours - ((100 - batteryLevel) * maxHours / 100)) * 60; //remaining time in minutes
        NSInteger hours = totMinutes / 60; // get hours
        NSInteger minutes = totMinutes - (hours *60); // get minutes
        if (hours < 0 || minutes < 0) {
            return [NSString stringWithFormat:@"ND"];
        }
        return [NSString stringWithFormat:@"%i小时%02i分钟",hours,minutes];
    } else
        return @"NS";
}

+ (NSString *)remainingHoursForAudio {
    CGFloat batteryLevel = [self batteryLevel];
    NSDictionary *info = [self infoForDevice];
    NSInteger maxHours = 0;
    if ([info objectForKey:@"standby"]) {
        maxHours = [[info objectForKey:@"audio"] integerValue];
        CGFloat totMinutes = (maxHours - ((100 - batteryLevel) * maxHours / 100)) * 60; //remaining time in minutes
        NSInteger hours = totMinutes / 60; //get hours
        NSInteger minutes = totMinutes - (hours * 60); // get minutes
        if (hours < 0 || minutes < 0) {
            return [NSString stringWithFormat:@"ND"];
        }
        return [NSString stringWithFormat:@"%i小时%02i分钟",hours,minutes];
    } else
        return @"NS";
}

////********************************************自己写的一些常用电池方法****************************************************
//根据iphone类型获取对应的电池容量
+ (NSString *)getBatteryCapacityByPhoneType
{
    NSString *strBatteryCapacity=nil;
    NSString *strPhoneType=[ALHardware getDeviceType];
    if ([strPhoneType isEqualToString:DeviceIPhone4]) {
        strBatteryCapacity = @"1420 mAh";
    } else if ([strPhoneType isEqualToString:DeviceIPhone4s]){
        strBatteryCapacity = @"1430 mAh";
    } else if ([strPhoneType isEqualToString:DeviceIPhone5]){
        strBatteryCapacity = @"1440 mAh";
    } else if ([strPhoneType isEqualToString:DeviceIPhone5s]){
        strBatteryCapacity = @"1570 mAh";
    } else if ([strPhoneType isEqualToString:DeviceIPhone5c]){
        strBatteryCapacity = @"1507 mAh";
    } else if ([strPhoneType isEqualToString:DeviceIPhone6]){
        strBatteryCapacity = @"1810 mAh";
    } else if ([strPhoneType isEqualToString:DeviceIPhone6Plus]){
        strBatteryCapacity = @"2915 mAh";
    } else if ([strPhoneType isEqualToString:DeviceSimulator]) {
        strBatteryCapacity = @"";
    }
    return strBatteryCapacity;
}

//根据iphone类型获取对应的电池充电电流
+ (NSString *)getBatteryStreamByPhoneType
{
    NSString *strBatteryStream=nil;
    NSString *strPhoneType=[ALHardware getDeviceType];
    if ([strPhoneType isEqualToString:DeviceIPhone4]) {
        strBatteryStream = @"1000 mA";
    } else if ([strPhoneType isEqualToString:DeviceIPhone4s]){
        strBatteryStream = @"1000 mA";
    } else if ([strPhoneType isEqualToString:DeviceIPhone5]){
        strBatteryStream = @"1000 mA";
    } else if ([strPhoneType isEqualToString:DeviceIPhone5s]){
        strBatteryStream = @"1000 mA";
    } else if ([strPhoneType isEqualToString:DeviceIPhone5c]){
        strBatteryStream = @"1000 mA";
    } else if ([strPhoneType isEqualToString:DeviceIPhone6]){
        strBatteryStream = @"1000 mA";
    } else if ([strPhoneType isEqualToString:DeviceIPhone6Plus]){
        strBatteryStream = @"1000 mA";
    } else if ([strPhoneType isEqualToString:DeviceSimulator]) {
        strBatteryStream = @"1000 mA";
    }
    return strBatteryStream;
}

//根据iphone类型获取对应的电池待机时间
+ (NSString *)getBatteryDurationTimeByPhoneType
{
    NSInteger deviceTime;
    NSString *strPhoneType=[ALHardware getDeviceType];
    
    if ([strPhoneType isEqualToString:DeviceIPhone4]) {
        deviceTime = 300;
    } else if ([strPhoneType isEqualToString:DeviceIPhone4s]){
        deviceTime = 200;
    } else if ([strPhoneType isEqualToString:DeviceIPhone5]){
        deviceTime = 225;
    } else if ([strPhoneType isEqualToString:DeviceIPhone5s]){
        deviceTime = 250;
    } else if ([strPhoneType isEqualToString:DeviceIPhone5c]){
        deviceTime = 250;
    } else if ([strPhoneType isEqualToString:DeviceIPhone6]){
        deviceTime = 250;
    } else if ([strPhoneType isEqualToString:DeviceIPhone6Plus]){
        deviceTime = 384;
    } else if ([strPhoneType isEqualToString:DeviceSimulator]) {
        deviceTime = 300;
    }
    //小时
    NSLog(@"deviceTime = %d",(int)deviceTime);
    float hour = deviceTime *[ALBattery batteryLevel]/100;
    NSString *strhour = [NSString stringWithFormat:@"%.f",hour];
    NSLog(@"预计待机 %.f 小时",hour);
    //分钟
    float min = hour * 60;
    NSLog(@"预计待机 %.f 分钟",min);
    
    return strhour;
}


@end
