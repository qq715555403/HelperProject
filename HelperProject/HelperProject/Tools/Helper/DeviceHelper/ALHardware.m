//
//  ALHardware.m
//  ALSystem
//
//  Created by Andrea Mario Lufino on 21/07/13.
//  Copyright (c) 2013 Andrea Mario Lufino. All rights reserved.
//

#import "ALHardware.h"
#define MIB_SIZE 2

@interface ALHardware ()

+ (NSDictionary *)infoForDevice;

@end

@implementation ALHardware

#pragma mark - Info for device

+ (NSDictionary *)infoForDevice {
    NSString *device = [ALHardware platformType];
    NSDictionary *info = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[device stringByReplacingOccurrencesOfString:@" " withString:@""] ofType:@"plist"]];
    return info;
}

#pragma mark - Methods

+ (NSString *)deviceModel {
    return [[UIDevice currentDevice] model];
}

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)systemName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSInteger)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (NSInteger)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)brightness {
    return [[UIScreen mainScreen] brightness]*100;
}

+ (NSString *)platformType {
    NSString *type;
    type=[ALHardware getDeviceType];
    return type;
}

+ (NSString *)bootTime {
    NSInteger ti = (NSInteger)[[NSProcessInfo processInfo] systemUptime];
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
}

+ (BOOL)proximitySensor {
    // Make a Bool for the proximity Sensor
    BOOL proximitySensor = NO;
    // Is the proximity sensor enabled?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setProximityMonitoringEnabled:)]) {
        // Create a UIDevice variable
        UIDevice *device = [UIDevice currentDevice];
        // Turn the sensor on, if not already on, and see if it works
        if (device.proximityMonitoringEnabled != YES) {
            // Sensor is off
            // Turn it on
            [device setProximityMonitoringEnabled:YES];
            // See if it turned on
            if (device.proximityMonitoringEnabled == YES) {
                // It turned on!  Turn it off
                [device setProximityMonitoringEnabled:NO];
                // It works
                proximitySensor = YES;
            } else {
                // Didn't turn on, no good
                proximitySensor = NO;
            }
        } else {
            // Sensor is already on
            proximitySensor = YES;
        }
    }
    // Return on or off
    return proximitySensor;
}

+ (BOOL)multitaskingEnabled {
    // Is multitasking enabled?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        // Create a bool
        BOOL multitaskingSupported = [UIDevice currentDevice].multitaskingSupported;
        // Return the value
        return multitaskingSupported;
    } else {
        // Doesn't respond to selector
        return NO;
    }
}

// 1.2

+ (NSString *)sim {
    return [[self infoForDevice] objectForKey:@"sim"];
}

+ (NSString *)dimensions {
    return [[self infoForDevice] objectForKey:@"dimensions"];
}

+ (NSString *)weight {
    return [[self infoForDevice] objectForKey:@"weight"];
}

+ (NSString *)displayType {
    return [[self infoForDevice] objectForKey:@"display-type"];
}

+ (NSString *)displayDensity {
    return [[self infoForDevice] objectForKey:@"display-density"];
}

+ (NSString *)WLAN {
    return [[self infoForDevice] objectForKey:@"WLAN"];
}

+ (NSString *)bluetooth {
    return [[self infoForDevice] objectForKey:@"bluetooth"];
}

+ (NSString *)cameraPrimary {
    return [[self infoForDevice] objectForKey:@"camera-primary"];
}

+ (NSString *)cameraSecondary {
    return [[self infoForDevice] objectForKey:@"camera-secondary"];
}

+ (NSString *)cpu {
    return [[self infoForDevice] objectForKey:@"cpu"];
}

+ (NSString *)gpu {
    return [[self infoForDevice] objectForKey:@"gpu"];
}

+ (BOOL)siri {
    if ([[[self infoForDevice] objectForKey:@"siri"] isEqualToString:@"Yes"])
        return YES;
    else
        return NO;
}

+ (BOOL)touchID {
    if ([[[self infoForDevice] objectForKey:@"touch-id"] isEqualToString:@"Yes"])
        return YES;
    else
        return NO;
}


//********************************************自己写的一些常用硬件方法****************************************************
#pragma mark - ---------------------------------

#pragma mark 获取ios版本号
+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

#pragma mark 获取ios app发布版本号
+(NSString *)getAppShortVersion
{
    //    代码实现获得应用的Verison号：
    NSString *strTemp=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //    或
    //    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return strTemp;
}

#pragma mark 获取ios build版本号
+(NSString *)getAppBuildVersion
{
    //    获得build号：
    NSString *strTemp=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return strTemp;
}


#pragma mark NSString和Address的转换
+ (NSString *) stringFromAddress: (const struct sockaddr *) address
{
//    if(address && address->sa_family == AF_INET) {
//        const struct sockaddr_in* sin = (struct sockaddr_in*) address;
//        return [NSString stringWithFormat:@"%@:%d", [NSString stringWithUTF8String:inet_ntoa(sin->sin_addr)], ntohs(sin->sin_port)];
//    }
//    
    return nil;
}
#pragma mark NSString和Address的转换
+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address
{
//    if (!IPAddress || ![IPAddress length]) {
//        return NO;
//    }
//    
//    memset((char *) address, sizeof(struct sockaddr_in), 0);
//    address->sin_family = AF_INET;
//    address->sin_len = sizeof(struct sockaddr_in);
//    
//    int conversionResult = inet_aton([IPAddress UTF8String], &address->sin_addr);
//    if (conversionResult == 0) {
//        NSAssert1(conversionResult != 1, @"Failed to convert the IP address string into a sockaddr_in: %@", IPAddress);
//        return NO;
//    }
    
    return YES;
}

#pragma mark 获取host的名称
+ (NSString *) hostname
{
    char baseHostName[256]; // Thanks, Gunnar Larisch
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    //    2015-07-30 19:32:36 update by 胡仕君
    //    baseHostName[255] = '/0';
    baseHostName[255] = '\0';
#if TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s", baseHostName];
#else
    return [NSString stringWithFormat:@"%s.local", baseHostName];
#endif
}

//#pragma mark 获取ip地址
//+ (NSString *) localIPAddress
//{
//    struct hostent *host = gethostbyname([[self hostname] UTF8String]);
//    if (!host) {herror("resolv"); return nil;}
//    struct in_addr **list = (struct in_addr **)host->h_addr_list;
//    
//    NSLog(@"ip = %@",[NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding]);
//    return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
//}
//
//#pragma mark 从host获取地址
//+ (NSString *) getIPAddressForHost: (NSString *) theHost
//{
//    struct hostent *host = gethostbyname([theHost UTF8String]);
//    if (!host) {herror("resolv"); return NULL; }
//    struct in_addr **list = (struct in_addr **)host->h_addr_list;
//    NSString *addressString = [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
//    return addressString;
//}

//#pragma mark 获取本机wifi的ip地址
//+ (NSString *) localWiFiIPAddress
//{
//    BOOL success;
//    struct ifaddrs * addrs;
//    const struct ifaddrs * cursor;
//    
//    success = getifaddrs(&addrs) == 0;
//    if (success) {
//        cursor = addrs;
//        while (cursor != NULL) {
//            // the second test keeps from picking up the loopback address
//            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
//            {
//                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
//                if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
//                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
//            }
//            cursor = cursor->ifa_next;
//        }
//        freeifaddrs(addrs);
//    }
//    return nil;
//}



#pragma mark - 获取设备平台版本信息
+ (NSString *)getDeviceVersionInfo
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithFormat:@"%s", systemInfo.machine];
    return platform;
}

#pragma mark 获取当前设备型号
+ (NSString *)getDeviceType
{
    NSString *correspondVersion = [self getDeviceVersionInfo];
    
    //************************************************模拟器************************************************
    if ([correspondVersion isEqualToString:@"i386"]){
        return DeviceIPhone6;
    }
    if ([correspondVersion isEqualToString:@"x86_64"]){
        return DeviceIPhone4s;
    }
    //************************************************iPhone************************************************
    if ([correspondVersion isEqualToString:@"iPhone1,1"]){
        return DeviceIPhone1;
    }
    if ([correspondVersion isEqualToString:@"iPhone1,2"]){
        return DeviceIPhone3;
    }
    if ([correspondVersion isEqualToString:@"iPhone2,1"]){
        return DeviceIPhone3s;
    }
    if ([correspondVersion isEqualToString:@"iPhone3,1"] || [correspondVersion isEqualToString:@"iPhone3,2"]){
        return DeviceIPhone4;
    }
    if ([correspondVersion isEqualToString:@"iPhone4,1"]){
        return DeviceIPhone4s;
    }
    if ([correspondVersion isEqualToString:@"iPhone5,1"] || [correspondVersion isEqualToString:@"iPhone5,2"]){
        return DeviceIPhone5;
    }
    if ([correspondVersion isEqualToString:@"iPhone5,3"] || [correspondVersion isEqualToString:@"iPhone5,4"]){
        return DeviceIPhone5c;
    }
    if ([correspondVersion isEqualToString:@"iPhone6,1"] || [correspondVersion isEqualToString:@"iPhone6,2"]){
        return DeviceIPhone5s;
    }
    if ([correspondVersion isEqualToString:@"iPhone7,1"]){
        return DeviceIPhone6Plus;
    }
    if ([correspondVersion isEqualToString:@"iPhone7,2"]){
        return DeviceIPhone6;
    }
    
    //************************************************iPod************************************************
    if ([correspondVersion isEqualToString:@"iPod1,1"]){
        return DeviceIPodTouch1;
    }
    if ([correspondVersion isEqualToString:@"iPod2,1"]){
        return DeviceIPodTouch2;
    }
    if ([correspondVersion isEqualToString:@"iPod3,1"]){
        return DeviceIPodTouch3;
    }
    if ([correspondVersion isEqualToString:@"iPod4,1"]){
        return DeviceIPodTouch4;
    }
    if ([correspondVersion isEqualToString:@"iPod5,1"]){
        return DeviceIPodTouch5;
    }
    //************************************************iPad************************************************
    if ([correspondVersion isEqualToString:@"iPad1,1"]){
        return DeviceIPad1;
    }
    if ([correspondVersion isEqualToString:@"iPad2,1"] || [correspondVersion isEqualToString:@"iPad2,2"] || [correspondVersion isEqualToString:@"iPad2,3"] || [correspondVersion isEqualToString:@"iPad2,4"]){
        return DeviceIPad2;
    }
    if ([correspondVersion isEqualToString:@"iPad3,1"] || [correspondVersion isEqualToString:@"iPad3,2"] ){
        return DeviceIPad3;
    }
    if ([correspondVersion isEqualToString:@"iPad3,4"] || [correspondVersion isEqualToString:@"iPad3,5"] ){
        return DeviceIPad4;
    }
    if ([correspondVersion isEqualToString:@"iPad2,5"] || [correspondVersion isEqualToString:@"iPad2,6"] || [correspondVersion isEqualToString:@"iPad2,7"] ){
        return DeviceIPadMini1;
    }
    if ([correspondVersion isEqualToString:@"iPad4,4"] || [correspondVersion isEqualToString:@"iPad4,5"]){
        return DeviceIPadMini2;
    }
    if ([correspondVersion isEqualToString:@"iPad4,7"] || [correspondVersion isEqualToString:@"iPad4,8"]){
        return DeviceIPadMini3;
    }
    if ([correspondVersion isEqualToString:@"iPad4,1"] || [correspondVersion isEqualToString:@"iPad4,1"] ){
        return DeviceIPadAir1;
    }
    if ([correspondVersion isEqualToString:@"iPad5,3"] || [correspondVersion isEqualToString:@"iPad5,4"] ){
        return DeviceIPadAir2;
    }else{//2015-08-06 15:49:27 add by 胡仕君：添加其他情况返回数据；比如刚出的新设备iPhone6s
        return DeviceIPhone5;
    }
    return correspondVersion;
}

//获取设备尺寸
+ (UIDeviceInch)getDeviceInch
{
    NSString *strDeviceType=[self getDeviceType];
    
    //iPhone1、3、3s、4、4s 都是3.5寸屏幕
    if ([strDeviceType isEqualToString:DeviceIPhone1]     ||
        [strDeviceType isEqualToString:DeviceIPhone3]     ||
        [strDeviceType isEqualToString:DeviceIPhone3s]    ||
        [strDeviceType isEqualToString:DeviceIPhone4]     ||
        [strDeviceType isEqualToString:DeviceIPhone4s]    ||
        [strDeviceType isEqualToString:DeviceIPodTouch1]  ||
        [strDeviceType isEqualToString:DeviceIPodTouch2]  ||
        [strDeviceType isEqualToString:DeviceIPodTouch3]  ||
        [strDeviceType isEqualToString:DeviceIPodTouch4]  ||
        [strDeviceType isEqualToString:DeviceIPodTouch5])
    {
        return UIDeviceInch35;
    }else if ([strDeviceType isEqualToString:DeviceIPhone5]  ||
              [strDeviceType isEqualToString:DeviceIPhone5c] ||
              [strDeviceType isEqualToString:DeviceIPhone5s]) {
        return UIDeviceInch40;
    }else if ([strDeviceType isEqualToString:DeviceIPhone6]){
        return UIDeviceInch47;
    }else if ([strDeviceType isEqualToString:DeviceIPhone6Plus]){
        return UIDeviceInch55;
    }else if([strDeviceType isEqualToString:DeviceIPad1] ||
             [strDeviceType isEqualToString:DeviceIPad2] ||
             [strDeviceType isEqualToString:DeviceIPad3] ||
             [strDeviceType isEqualToString:DeviceIPad4])
    {
        return UIDeviceInch97;
    }else if([strDeviceType isEqualToString:DeviceIPadMini1]||
             [strDeviceType isEqualToString:DeviceIPadMini2] ||
             [strDeviceType isEqualToString:DeviceIPadMini3])
    {
        return UIDeviceInch79;
    }else{
        return UIDeviceInch40;
    }
}

#pragma mark - 打开关闭闪光灯
+(void)turnOffFlashlight
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
    
}

+(void)turnOnFlashlight
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
}


#pragma mark  内存使用状况
// 获取当前设备可用内存(单位：MB）
+ (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

#pragma mark 占用的内存（单位：MB）
+ (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

//NSFileManager包含非常丰富的信息，通过下面的方法可很容易的获取系统磁盘的大小和可用磁盘的大小
#pragma mark 总的磁盘空间
+ (float)getTotalDiskspace{
    float totalSpace;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
    } else {
        totalSpace = 0;
    }
    
    return totalSpace;
}
#pragma mark 可用磁盘空间
+ (float)getFreeDiskspace{
    float freeSpace;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        freeSpace = [freeFileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
    } else {
        freeSpace = 0;
    }
    
    return freeSpace;
}
@end
