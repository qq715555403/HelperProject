//
//  TotalBaseViewController.m
//  demo
//
//  Created by hushijun on 15/5/5.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import "TotalBaseViewController.h"

@implementation TotalBaseViewController
{
    UIImageView *_lostconnect; //网络出错后展示的友好图片
}

- (void)dealloc
{
    _lostconnect=nil;
}


- (void)loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    return;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = RGBAColor(226, 226, 226, 1);
    self.view.backgroundColor = [UIColor whiteColor];

//    self.hidesBottomBarWhenPushed = YES;
    
//    [self setNavCtrl];
    

    //注册网络变化通知中心
    //    [NotificationCenterClass addObserver:self selector:@selector(netWorkStatusChanged:) name:kReachabilityChangedNotification object:nil];
    
    //    [self handleThemeChangedNotification:nil];
    //    //在父类中注册通知，免得在其他所有vc中都注册，显得代码冗余
    //    [NotificationCenter addObserver:self selector:@selector(handleThemeChangedNotification:) name:kISTChangeThemeNotificaion object:nil];
    
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//
//    //改变所有状态栏颜色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//
//
//}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    
//    [NotificationCenterClass postNotificationName:HiddenOrShowStatusBar object:nil userInfo:@{@"status":@"show"}];
//    
//    self.navigationController.navigationBar.hidden=NO;
//    self.navigationController.navigationBar.translucent = NO;
//}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO; //隐藏系统tabbar
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES; //隐藏系统tabbar
    
    self.navigationController.navigationBar.translucent = NO;
}


//控制push的子vc能否手势划回上一个vc
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//-(void)setNavCtrl
//{
//    self.navigationController.navigationBar.hidden=NO;
//    
//    //改变所有状态栏颜色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    
//    //改变导航栏字体 和 颜色 全局的
//    [[UINavigationBar appearance] setTitleTextAttributes:@{
//                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
//                                                           NSForegroundColorAttributeName:[UIColor whiteColor]
//                                                           }]; // 设置导航栏字体
//    //ios7改变导航栏 背景颜色  全局的
//    [[UINavigationBar appearance] setBarTintColor:RGBAColor(68, 166, 242, 1)];
//    //改变所有导航栏的背景图片
////    [[UINavigationBar appearance] setBackgroundImage:LoadBundleImageByName(@"common/com_nav_bg.png") forBarMetrics:UIBarMetricsDefault];
//    
//    //改变所有导航栏按钮上的字的颜色
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    
//    //修改导航栏返回按钮图片
//    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back_btn.png"]];
//    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_btn.png"]];
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//#pragma mark - 父类中配置ui的方法
////父类无需实现
//-(void) configUIAppearance
//{
//    NSLog(@"父类-BaseViewController中的configUIAppearance~");
//}
//
//-(void) configNavigationBar:(NSString *) theme
//{
//    if ([theme isEqualToString:@"yellow"]) {
//        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
//            // Load resources for iOS 6.1 or earlier
////            self.navigationController.navigationBar.tintColor = [UIColor yellowColor];
//            self.navigationController.navigationBar.tintColor = RGBColor(244, 186, 72);
//        }else {
//            // Load resources for iOS 7 or later
////            self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
//            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//            self.navigationController.navigationBar.barTintColor= RGBColor(244, 186, 72);
//        }
//    }
//
//    if ([theme isEqualToString:@"blue"]) {
//        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
//            // Load resources for iOS 6.1 or earlier
////            self.navigationController.navigationBar.tintColor = [UIColor blueColor];
//            self.navigationController.navigationBar.tintColor = RGBColor(141, 193, 255);
//        }else {
//            // Load resources for iOS 7 or later
////            self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
//            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//            self.navigationController.navigationBar.barTintColor = RGBColor(141, 193, 255);
//        }
//    }
//
//    if ([theme isEqualToString:@"red"]) {
//        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
//            // Load resources for iOS 6.1 or earlier
////            self.navigationController.navigationBar.tintColor = [UIColor redColor];
//            self.navigationController.navigationBar.tintColor = RGBColor(249, 162, 163);
//        }else {
//            // Load resources for iOS 7 or later
////            self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//            self.navigationController.navigationBar.barTintColor = RGBColor(249, 162, 163);
//        }
//    }
//}

//#pragma mark - 监听主题改变
//- (void)handleThemeChangedNotification:(NSNotification*)notification{
//    NSString *theme = [UserDefault objectForKey:@"theme"];
//    if (theme && theme.length>0) {
////        NSDictionary *dic=notification.userInfo;
////        NSString *theme=[dic objectForKey:@"theme"];
//        [self configNavigationBar:theme];
//    } else {
//        [self configNavigationBar:@"yellow"];
//    }
//
//    //如果子类有此方法，就调用子类的，如果子类没有，就调用父类的
//    [self configUIAppearance];
//}


//#pragma mark  - 监听网络状态改变时
//- (void)netWorkStatusChanged:(NSNotification *)note {
//    Reachability* curReach = [note object];
//    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
//    NetworkStatus status = [curReach currentReachabilityStatus];
//
//    if (status == NotReachable) { //网络不可用时
//        [CPToast hiddenMBProgressHUDForView:self.view];
//        [self createImageWithLostConnect];
//    } else {
////        [CPToast addMBProgressHUD:@"加载中..." toView:self.view];
//        if (_lostconnect) {
//            [_lostconnect removeFromSuperview];
//            _lostconnect=nil;
//        }
//    }
//}

#pragma mark - 创建网络失败的图片视图
//创建网络失败的图片视图和隐藏图片视图
-(void) createImageWithLostConnect
{
    if (_lostconnect==nil) {
        _lostconnect = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64 )];
        _lostconnect.center = CGPointMake(kScreen_Width/2, (kScreen_Height - 64)/2);
        _lostconnect.backgroundColor = RGBAColor(255, 255, 255, 1);
        _lostconnect.userInteractionEnabled=YES;
        _lostconnect.contentMode=UIViewContentModeCenter;
        [_lostconnect setImage:LoadBundleImageByName(@"common/com_network_fail.png")];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgLostConnectTaped:)];
        tap.numberOfTouchesRequired=1;//手指个数
        tap.numberOfTapsRequired=1; //点击次数
        tap.delegate=self;
        [_lostconnect addGestureRecognizer:tap];
        
        [self.view addSubview:_lostconnect];
    }
}
-(void) createImageWithLostConnectWithErrorInfo:(NSString *) errorInfo
{
    errorInfo=@"无法连接到网络,请稍后再试";
    [StatusBarTipsWindowClass showTipsWithImage:LoadBundleImageByName(@"common/com_network_status.png") message:errorInfo hideAfterDelay:AnimateHiddenAfter];
    //    [StatusBarTipsWindowClass showTips:[NSString stringWithFormat:@"   %@",errorInfo] hideAfterDelay:AnimateHiddenAfter];
    [self createImageWithLostConnect];
}
#pragma mark  隐藏网络失败的图片视图
-(void) hideImageWithLostConnect
{
    if (_lostconnect) {
        [_lostconnect removeFromSuperview];
        _lostconnect=nil;
    }
}

#pragma mark  网络失败的图片视图点击手势
-(void) imgLostConnectTaped:(UITapGestureRecognizer *) tap
{
    NSLog(@"父类imgLostConnectTaped。。。");
    //没有实现代码，一般调用子类的对应方法进行处理
}



@end
