//
//  ALHardware.h
//  ALSystem
//
//  Created by Andrea Mario Lufino on 21/07/13.
//  Copyright (c) 2013 Andrea Mario Lufino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <AVFoundation/AVFoundation.h>
#import <mach/mach.h>

//#include <sys/utsname.h>
//#include <sys/types.h>
//#include <sys/sysctl.h>
//#include <net/if.h>
//#include <net/if_dl.h>

#import <sys/utsname.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

////********************************************自己定义的常用宏及枚举值****************************************************
//模拟器
#define DeviceSimulator     @"Simulator"
//iPhone设备
#define DeviceIPhone1       @"iPhone1"
#define DeviceIPhone3       @"iPhone3"
#define DeviceIPhone3s      @"iPhone3s"
#define DeviceIPhone4       @"iPhone4"
#define DeviceIPhone4s      @"iPhone4s"
#define DeviceIPhone5       @"iPhone5"
#define DeviceIPhone5s      @"iPhone5s"
#define DeviceIPhone5c      @"iPhone5c"
#define DeviceIPhone6       @"iPhone6"
#define DeviceIPhone6Plus   @"iPhone6Plus"
#define DeviceIPhone6s      @"iPhone6s"
//iPod设备
#define DeviceIPodTouch1    @"iPodTouch1"
#define DeviceIPodTouch2    @"iPodTouch2"
#define DeviceIPodTouch3    @"iPodTouch3"
#define DeviceIPodTouch4    @"iPodTouch4"
#define DeviceIPodTouch5    @"iPodTouch5"
//iPad设备
#define DeviceIPad1         @"iPad1"
#define DeviceIPad2         @"iPad2"
#define DeviceIPad3         @"iPad3"
#define DeviceIPad4         @"iPad4"
#define DeviceIPadMini1     @"iPadMini"
#define DeviceIPadMini2     @"iPadMini2"
#define DeviceIPadMini3     @"iPadMini3"
#define DeviceIPadAir1      @"iPadAir"
#define DeviceIPadAir2      @"iPadAir2"

//设备尺寸枚举
typedef enum {
    //*****************iPhone尺寸*****************
    // iPhone 1,3,3GS 标准分辨率(320x480px)、iPhone 4,4S 高清分辨率(640x960px)
    UIDeviceInch35 = 1,
    // iPhone 5 高清分辨率(640x1136px)
    UIDeviceInch40 = 2,
    //iPhone 6 高清分辨率{750, 1334}
    UIDeviceInch47 = 3,
    //iPhone 6 Plus 高清分辨率{1242, 2208}
    UIDeviceInch55 = 4,
    
    //*****************iPad尺寸*****************
    // iPad 1,2 标准分辨率(1024x768px)
    // iPad 3 High Resolution(2048x1536px)
    
    // ipad mini
    UIDeviceInch79 = 5,
    // 其他ipad
    UIDeviceInch97 = 6,
    
    UIDeviceInchIPad =7
} UIDeviceInch;
////********************************************自己定义的常用宏及枚举值****************************************************


/*!
 * This class check some hardware (and software) informations
 */
@interface ALHardware : NSObject

/*!
 Check the device model
 @return NSString with the device model
 */
+ (NSString *)deviceModel;

/*!
 Check the device name
 @return NSString with the device name
 */
+ (NSString *)deviceName;

/*!
 Check the system name
 @return NSString with the system name
 */
+ (NSString *)systemName;

/*!
 Check the system version
 @return NSString with the system version
 */
+ (NSString *)systemVersion;

/*!
 Check the screen width in pixel
 @return NSInteger value of the width of the screen
 */
+ (NSInteger)screenWidth;

/*!
 Check the screen height in pixel
 @return NSInteger value of the height of the screen
 */
+ (NSInteger)screenHeight;

/*!
 Check the screen brightness
 @return CGFloat value of the brightness of the screen
 */
+ (CGFloat)brightness;

/*!
 Get the device type
 @return NSString represents the platform type (ex. : iPhone 5)
 */
+ (NSString *)platformType;

/*!
 Get the boot time in hours, minutes and seconds
 @return NSString represents the boot time in hours, minutes and seconds
 */
+ (NSDate *)bootTime;

/*!
 Check for the proximity sensor
 @return YES if the proximity sensor exist, NO if it isn't
 */
+ (BOOL)proximitySensor;

/*!
 Check if the multitasking is enabled
 @return YES if the multitasking is enabled, NO if it isn't
 */
+ (BOOL)multitaskingEnabled;

// 1.2

/*!
 The sim type
 @return NSString with the sim type
 */
+ (NSString *)sim;

/*!
 The device's dimensions
 @return NSString with the dimensions
 */
+ (NSString *)dimensions;

/*!
 The weight of the device
 @return NSString with the weight of the device
 */
+ (NSString *)weight;

/*!
 The display type of the device
 @return NSString with the display type
 */
+ (NSString *)displayType;

/*!
 The display density
 @return NSString with the display density
 */
+ (NSString *)displayDensity;

/*!
 The WLAN type
 @return NSString with the WLAN type
 */
+ (NSString *)WLAN;

/*!
 The bluetooth version
 @return NSString with the bluetooth version
 */
+ (NSString *)bluetooth;

/*!
 Details about primary camera of the device
 @return NSString with details about primary camera
 */
+ (NSString *)cameraPrimary;

/*!
 Details about secondary camera of the device
 @return NSString with details about secondary camera
 */
+ (NSString *)cameraSecondary;

/*!
 The cpu of the device
 @return NSString with the cpu of the device
 */
+ (NSString *)cpu;

/*!
 The gpu of the device
 @return NSString with the gpu of the device
 */
+ (NSString *)gpu;

/*!
 Check for Siri
 @return YES if Siri is present, NO if it isn't
 */
+ (BOOL)siri;

/*!
 Check for the Touch ID
 @return YES if Touch ID is present, NO if it isn't
 */
+ (BOOL)touchID;


//********************************************自己写的一些常用硬件方法****************************************************
#pragma mark - ---------------------------------
#pragma mark 获取ios版本号
+ (float)getIOSVersion;
#pragma mark 获取ios app发布版本号
+(NSString *)getAppShortVersion;
#pragma mark 获取ios build版本号
+(NSString *)getAppBuildVersion;

#pragma mark NSString和Address的转换
+ (NSString *) stringFromAddress: (const struct sockaddr *) address;
#pragma mark NSString和Address的转换
+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address;

#pragma mark 获取host的名称
+ (NSString *) hostname;
#pragma mark 获取ip地址
+ (NSString *) localIPAddress;
#pragma mark 从host获取地址
+ (NSString *) getIPAddressForHost: (NSString *) theHost;
#pragma mark 获取本机wifi的ip地址
+ (NSString *) localWiFiIPAddress;


//获取设备平台版本信息
+ (NSString *)getDeviceVersionInfo;
//获取设备类型
+ (NSString *)getDeviceType;
//获取设备尺寸
+ (UIDeviceInch)getDeviceInch;

#pragma mark - 打开关闭闪光灯
+ (void)turnOffFlashlight;
+ (void)turnOnFlashlight;


#pragma mark  内存使用状况
// 获取当前设备可用内存(单位：MB）
+ (double)availableMemory;
#pragma mark 占用的内存（单位：MB）
+ (double)usedMemory;

#pragma mark 总的磁盘空间:(单位：GB)
+ (float)getTotalDiskspace;
#pragma mark 可用磁盘空间:(单位：GB)
+ (float)getFreeDiskspace;

@end
