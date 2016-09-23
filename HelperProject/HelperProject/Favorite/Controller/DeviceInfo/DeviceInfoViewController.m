//
//  DeviceInfoViewController.m
//  DeviceInfo
//
//  Created by cxl on 12-8-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "DeviceInfoViewController.h"
#import "UIDevice-Hardware.h"

@implementation DeviceInfoViewController
@synthesize platform, cpuType, cpuFrequency, cpuCount, cpuUsage, totalMemory, freeMemory, totalDiskSpace, freeDiskSpace, batteryLevel, bluetoothCheck, isJailBreak;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [self.platform release];
    [self.cpuType release];
    [self.cpuFrequency release];
    [self.cpuCount release];
    [self.cpuUsage release];
    [self.totalMemory release];
    [self.freeMemory release];
    [self.totalDiskSpace release];
    [self.freeDiskSpace release];
    [self.batteryLevel release];
    [self.bluetoothCheck release];
    [self.isJailBreak release];
    [super dealloc];
}

- (void)refresh
{
    UIDevice *device = [UIDevice currentDevice];
    NSArray *usage = [device cpuUsage];
    NSMutableString *usageStr = [NSMutableString stringWithFormat:@""];
    for (NSNumber *u in usage) {
        [usageStr appendString:[NSString stringWithFormat:@"%f%% ", [u floatValue]]];
    }
    NSLog(@"CPU使用率：%@",usageStr);
    self.cpuUsage.text = usageStr;
    self.freeMemory.text = [NSString stringWithFormat:@"%uK", [device freeMemoryBytes] / 1024];
    self.freeDiskSpace.text = [NSString stringWithFormat:@"%lldM", [device freeDiskSpaceBytes] / (1024*1024)];
    self.batteryLevel.text = [NSString stringWithFormat:@"%.2f%%", [device batteryLevel] * 100];
}

#pragma mark - View lifecycle

/**/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIDevice *device = [UIDevice currentDevice];
    
    float upY=64;
    float offsetX=140;
    float lblWidth=200;
    
    //平台型号
    UILabel *label;
    label = [[UILabel alloc] initWithFrame:CGRectMake(20,upY+ 35, 150, 20)];
    label.text = @"平台型号:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX,upY+ 35, lblWidth, 20)];
    label.text = [device platformString];
    [self.view addSubview:label];
    self.platform = label;
    [label release];
    
    //cpu型号
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, upY+ 60, 150, 20)];
    label.text = @"cpu型号:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, upY+ 60, lblWidth, 20)];
    label.text = [device cpuType];
    [self.view addSubview:label];
    self.cpuType = label;
    [label release];
    
    //cpu频率
    label = [[UILabel alloc] initWithFrame:CGRectMake(20,upY+  85, 150, 20)];
    label.text = @"cpu频率:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX,upY+  85, lblWidth, 20)];
    label.text = [device cpuFrequency];
    [self.view addSubview:label];
    self.cpuFrequency = label;
    [label release];
    
    //cpu核数
    label = [[UILabel alloc] initWithFrame:CGRectMake(20,upY+  110, 150, 20)];
    label.text = @"cpu核数:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, upY+ 110, lblWidth, 20)];
    label.text = [NSString stringWithFormat:@"%u", [device cpuCount]];
    [self.view addSubview:label];
    self.cpuCount = label;
    [label release];
    
    //cpu使用率
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, upY+ 135, 150, 20)];
    label.text = @"cpu使用率:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(120, upY+ 135, 300, 20)];
    NSArray *usage = [device cpuUsage];
    NSMutableString *usageStr = [NSMutableString stringWithFormat:@""];
    for (NSNumber *u in usage) {
        [usageStr appendString:[NSString stringWithFormat:@"%f%% ", [u floatValue]]];
    }
    NSLog(@"CPU使用率：%@",usageStr);
    label.text = usageStr;
    [self.view addSubview:label];
    self.cpuUsage = label;
    [label release];
    
    //总内存
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, upY+ 160, 150, 20)];
    label.text = @"总内存:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, upY+ 160, lblWidth, 20)];
    label.text = [NSString stringWithFormat:@"%uK", [device totalMemoryBytes] / 1024];
    [self.view addSubview:label];
    self.totalMemory = label;
    [label release];
    
    //可用内存
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, upY+ 185, 150, 20)];
    label.text = @"可用内存:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, upY+ 185, lblWidth, 20)];
    label.text = [NSString stringWithFormat:@"%uK", [device freeMemoryBytes] / 1024];
    [self.view addSubview:label];
    self.freeMemory = label;
    [label release];
    
    //硬盘总空间
    label = [[UILabel alloc] initWithFrame:CGRectMake(20,upY+  210, 150, 20)];
    label.text = @"硬盘总空间:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, upY+ 210, lblWidth, 20)];
    label.text = [NSString stringWithFormat:@"%lldM", [device totalDiskSpaceBytes] / (1024*1024)];
    [self.view addSubview:label];
    self.totalDiskSpace = label;
    [label release];
    
    //可用硬盘空间
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, upY+ 235, 150, 20)];
    label.text = @"可用硬盘空间:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, upY+ 235, lblWidth, 20)];
    label.text = [NSString stringWithFormat:@"%lldM", [device freeDiskSpaceBytes] / (1024*1024)];
    [self.view addSubview:label];
    self.freeDiskSpace = label;
    [label release];
    
    //电池电量
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, upY+ 260, 150, 20)];
    label.text = @"电池电量:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, upY+ 260, lblWidth, 20)];
    device.batteryMonitoringEnabled = YES;
    label.text = [NSString stringWithFormat:@"%.2f%%", [device batteryLevel] * 100];
    [self.view addSubview:label];
    self.batteryLevel = label;
    [label release];
    
    //是否支持蓝牙
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, upY+ 285, 150, 20)];
    label.text = @"是否支持蓝牙:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX,upY+  285, lblWidth, 20)];
    label.text = [NSString stringWithFormat:@"%@", [device bluetoothCheck] ? @"支持" : @"不支持"];
    [self.view addSubview:label];
    self.bluetoothCheck = label;
    [label release];
    
    //是否越狱
    label = [[UILabel alloc] initWithFrame:CGRectMake(20,upY+  310, 150, 20)];
    label.text = @"是否越狱:";
    [self.view addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(offsetX,upY+  310, lblWidth, 20)];
    label.text = [NSString stringWithFormat:@"%@", [device isJailBreak] ? @"已越狱" : @"未越狱"];
    [self.view addSubview:label];
    self.isJailBreak = label;
    [label release];
    
    if (timerCPUUsage) {
        [timerCPUUsage invalidate];
        timerCPUUsage=nil;
    }
    timerCPUUsage=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (timerCPUUsage) {
        [timerCPUUsage invalidate];
        timerCPUUsage=nil;
    }
}




@end
