//
//  AppDelegate.m
//  HelperProject
//
//  Created by hushijun on 15/8/8.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "AppDelegate.h"
#import "PasswordInputWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    NSString *_WxAppID;
}

- (void)umengTrack {
    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:NO];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    
    //2015-09-09 14:04:42 add by 胡仕君；
    [MobClick setEncryptEnabled:YES];//设置是否对日志信息进行加密, 默认NO(不加密).
    [MobClick setBackgroundTaskEnabled:YES];/** 设置是否开启background模式, 默认YES. */
    
    
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //    [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
    
    //2015-08-24 14:57:06 update by 胡仕君：添加keywindow的监听
    [NotificationCenterClass addObserver:self selector:@selector(setKeyWindowAndVisible:) name:@"SetKeyWindowAndVisible" object:nil];
    
    [self setNavCtrl];
    
    
    [self initCustomData];
    
    //以下代码：方便测试自定义tab及进入后台后弹出密码window的功能
//    [self createTabCtrl];
//    
//    NSString *strTemp=[UserDefaultClass objectForKey:@"isGoBack"];
//    NSLog(@"strTemp==%@",strTemp);
//    if ([strTemp isEqualToString:@"yes"]) {
//        PasswordInputWindow *pwindow=[PasswordInputWindow sharedInstance];
//        [pwindow show];
//    }

//    [self registerObserver];
    
    
    //测试为什么类目不能添加属性
    NSString *str=@"ninhao";
    str.strTest=@"111";
    NSLog(@"str.strTest==%@",str.strTest);
    
//    //测试@dynamic
//    [self testBook];
    
//    测试到appstore去评分的功能
//    [self appIraterTest];
    
////    测试状态栏提示控件
//    [self mtstatusBarTest];

    [self settingUUID];
    
    
    [ShareHelper registerShareSDKWithAppID:@"4893c76986e4" weixinID:@"wx0bb7f5b66848f59c" weixinAppSecret:nil];
    
    
    [self adaptive64Bit];
    
    
    [self testXcodePlugin];
    
    
    
    
    return YES;
}
- (void) testXcodePlugin
{
//    SCXcodeSwitchExpander 插件
//    UITableViewRowAnimation anim;
//    switch (anim) {
//        case UITableViewRowAnimationFade: {
//            <#statement#>
//            break;
//        }
//        case UITableViewRowAnimationRight: {
//            <#statement#>
//            break;
//        }
//        case UITableViewRowAnimationLeft: {
//            <#statement#>
//            break;
//        }
//        default: {
//            break;
//        }
//    }
    
    //    NSDictionary
    
    //    WKWebView
    
    
    
}



//适配64位注意事项
- (void) adaptive64Bit
{
    
#warning 一、拒绝基本数据类型和隐式转换
//    
//    首当其冲的就是基本类型，比如下面4个类型在32-bit和64-bit下分别是多长呢？
//    size_t s1 = sizeof(int);
//    size_t s2 = sizeof(long);
//    size_t s3 = sizeof(float);
//    size_t s4 = sizeof(double);
//    32-bit下：4, 4, 4, 8；64-bit下：4, 8, 4, 8
//    
//    （PS： 这个结果随编译器，换其他平台可不一定）
//    
//    它们的长度变化可能并非我们对64-bit长度加倍的预期，所以说，程序中出现sizeof的代码多看两眼。而且，除非你明确知道自己在做什么，应该使用下面的类型代替基本类型：
//    
//    int -> NSInteger
//    unsigned -> NSUInteger
//    float -> CGFloat
//    动画时间 -> NSTimeInterval
//    …
//    这些都是SDK中定义的类型，而我们大部分时间都在跟SDK的API们打交道，使用它们能将类型转换的影响降低很多。
    
    
    //64bit 导致循环体里面永远都不运行:比较i和count的时候，i->转换为NSUInteger
    //    数组的count是NSUInteger类型的，-1与其比较时隐式转换成NSUInteger，变成了一个很大的数字：
    //    (lldb) p i
    //    (int) $0 = -1
    //    (lldb) p (NSUInteger)i
    //    (NSUInteger) $1 = 18446744073709551615
    //    这和64-bit到没啥关系，想要说明的是，这种隐式转换也需要小心，一定要注意和这个变量相关的所有操作（赋值、比较、转换）
    //    老式for循环可以考虑写成：
    //        for (NSUInteger index = 0; index < items.count; index++) {}
    //    当然，数组遍历还是更推荐用for-in或block版本的，它们之间的比较可以回顾下这篇文章。
    NSArray *items = @[@1, @2, @3];
    for (int i = -1; i < items.count; i++) {
        NSLog(@"%d", i);//这里永远不会执行（64位系统）
    }
    
#warning 二、使用新版枚举
//    和上面的原因差不多，枚举应该使用新版的写法：
//    typedef NS_ENUM(NSInteger, UIViewAnimationCurve) {
//        UIViewAnimationCurveEaseInOut,
//        UIViewAnimationCurveEaseIn,
//        UIViewAnimationCurveEaseOut,
//        UIViewAnimationCurveLinear
//    };
//    不仅能为枚举值指定类型，而且当赋值赋错类型时，编译器还会给出警告，没理由不用这种写法。
    
#warning 三、替代Format字符串
//    
//    适配64-bit时，你是否遇到了下面的恶心写法：
//
//    NSArray *items = @[@1, @2, @3];
//    NSLog(@"数组元素个数：%lu", (unsigned long)items.count);
//    一般情况下，利用NSNumber的@语法糖就可以解决：
//
//    NSArray *items = @[@1, @2, @3];
//    NSLog(@"数组元素个数：%@", @(items.count));
//    同理，int转string也可以：
//
//    NSInteger i = 10086;
//    NSString *string = @(i).stringValue;
//    当然，如需要%.2f这种Format就不适用了。
    
#warning 四、64-bit下的BOOL
//    
//    32-bit下，BOOL被定义为signed char，@encode(BOOL)的结果是'c'
//    
//    64-bit下，BOOL被定义为bool，@encode(BOOL)结果是'B'
//    
//    更直观的解释是：
//    (lldb) p/t (signed char)7
//    (BOOL) $0 = 0b00000111 (YES)
//    (lldb) p/t (bool)7
//    (bool) $1 = 0b00000001 (YES)
//    32-bit版本的BOOL包括了256个值的可能性，还会引起一些坑，像这篇文章所说的。而64-bit下只有0（NO），1（YES）两种可能，终于给BOOL正了名。
//    
#warning 五、不直接取isa指针
//    
//    编译器已经默认禁用了这种使用，isa指针在32位下是Class的地址，但在64位下利用bits mask才能取出来真正的地址，若真需要，使用runtime的object_getClass 和object_setClass方法。关于64位下isa的讲解可以看这篇文章
//    
#warning 六、解决第三方lib依赖和lipo命令
//    
//    以源码形式出现在工程中的第三方lib，只要把target加上arm64编译就好了。
//    
//    恶心的就是直接拖进工程的那些静态库(.a)或者framework，就需要重新找支持64-bit的包了。这时候就能看出哪些是已无人维护的lib了，是时候找个替代品了（比如我全网找不到工程中用到的一个音频库的64位包，终于在一个哥们的github上找到，哭着给了个star- -）
//    
#warning 七、打印Mach-O文件支持的架构
//    
//    如何看一个可执行文件是不是支持64-bit呢？
//    
//    使用lipo -info命令，比如看看UIKit支持的架构：
//    // 当前在Xcode Frameworks目录
//    sunnyxx$ lipo -info UIKit.framework/UIKit
//    Architectures in the fat file: UIKit.framework/UIKit are: arm64 armv7s
//    
//    想看的更详细的信息可以使用lipo -detailed_info：
//    sunnyxx$ lipo -detailed_info UIKit.framework/UIKit
//    Fat header in: UIKit.framework/UIKit
//    fat_magic 0xcafebabe
//    nfat_arch 2
//    architecture arm64
//    cputype CPU_TYPE_ARM64
//    cpusubtype CPU_SUBTYPE_ARM64_ALL
//    offset 4096
//    size 16822272
//    align 2^12 (4096)
//    architecture armv7s
//    cputype CPU_TYPE_ARM
//    cpusubtype CPU_SUBTYPE_ARM_V7S
//    offset 16826368
//    size 14499840
//    align 2^12 (4096)
//    
//    当然，还可以使用file命令：
//    sunnyxx$ file UIKit.framework/UIKit
//    UIKit.framework/UIKit: Mach-O universal binary with 2 architectures
//    UIKit.framework/UIKit (for architecture arm64):Mach-O 64-bit dynamically linked shared library
//    UIKit.framework/UIKit (for architecture armv7s):Mach-O dynamically linked shared library arm
//    上述命令对Mach-O文件适用，静态库.a文件，framework中的.a文件，自己app的可执行文件都可以打印下看看。
//    
#warning 八、合并多个架构的包
//    
//    如果，我们有MyLib-32.a和MyLib-64.a，可以使用lipo -create命令合并：
//    sunnyxx$ lipo -create MyLib-32.a MyLib-64.a -output MyLib.a
//    支持64-bit后程序包会变大么？
//    
//    会，支持64-bit后，多了一个arm64架构，理论上每个架构一套指令，但相比原来会大多少还不好说，我们这里增加了大概50%，还有听说会增加一倍的。
//    
//    一个lib包含了很多的架构，会打到最后的包里么？
//    
//    不会，如果lib中有armv7, armv7s, arm64, i386架构，而target architecture选择了armv7s, arm64，那么只会从lib中link指定的这两个架构的二进制代码，其他架构下的代码不会link到最终可执行文件中；反过来，一个lib需要在模拟器环境中正常link，也得包含i386架构的指令。
//    
#warning 九、Checklist
//    
//    最后列一下官方文档中的注意点：
//    
//    不要将指针强转成整数
//    程序各处使用统一的数据类型
//    对不同类型的整数做运算时一定要注意
//    需要定长变量时，使用如int32_t, int64_t这种定长类型
//    使用malloc时，不要写死size
//    使用能同时适配两个架构的格式化字符串
//    注意函数和函数指针（类型转换和可变参数）
//    不要直接访问Objective-C的指针（isa）
//    使用内建的同步原语（Primitives）
//    不要硬编码虚存页大小
//    Go Position Independent
}

- (void) settingUUID
{
    //删除序列号。
    // [[CMachineKeyStore sharedInstance]deleteMachineKey] ;
    
    if (![[CMachineKeyStore sharedInstance] isMachineKeyExsit]) {
        [[CMachineKeyStore sharedInstance] createAndStoreMachinKey];
    }else{
        NSLog(@"已经存在uuid~~~:%@",[[CMachineKeyStore sharedInstance] getMachineKey]);
    }
}

#pragma mark - 设置主window为keywindow和可见
//2015-08-24 14:57:06 update by 胡仕君：添加keywindow的监听
-(void)setKeyWindowAndVisible:(NSNotification *) notiy
{
    [self.window makeKeyAndVisible];
}


-(void) initCustomData
{
    //在sharesdk上注册APP
//    _WxAppID = @"wx0bb7f5b66848f59c";
//    [ShareSDK registerApp:@"4893c76986e4"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"pay"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[VersionUpdateHelper sharedInstance] checkVersion];
}

-(void) createTabCtrl
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *vc1=[[UIViewController alloc]init];
    vc1.title=@"测试1";
    UINavigationController *nvc1=[[UINavigationController alloc]initWithRootViewController:vc1];
    //    nvc1.title=@"测试1";
    
    UIViewController *vc2=[[UIViewController alloc]init];
    vc2.title=@"测试2";
    UINavigationController *nvc2=[[UINavigationController alloc]initWithRootViewController:vc2];
    //    nvc2.title=@"测试2";
    
    UITabBarController *tab=[[UITabBarController alloc]init];
    tab.viewControllers=@[nvc1,nvc2];
    tab.selectedIndex=0;
    self.window.rootViewController=tab;
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)updateStatus:(NSNotification *)notiy
{
//    [self initCustomData];
//    [self createTabCtrl];
    
//    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [UserDefaultClass setObject:@"yes" forKey:@"isGoBack"];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    
    
    
    //    如果涉及其他应用交互,请做如下判断,例如:还可能和新浪微博进行交互
    //    if ([url.scheme isEqualToString:_WxAppID]) {
    
    //    }
    //
    //
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //            NSLog(@"result = %@",resultDic);
        }];
    } else{
        
    }
    return [WXApi handleOpenURL:url delegate:self];
    //    return YES;
}
- (void)onResp:(BaseResp *)resp{
    
    NSLog(@"返回结果");
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:{
                strMsg = @"支付结果：成功！";
                NSDictionary *dic = [NSDictionary dictionaryWithObject:@"1" forKey:@"result"];
                [NotificationCenterClass postNotificationName:@"wx" object:nil userInfo:dic ];
                
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
            }
                
            default:{
                NSDictionary *dic = [NSDictionary dictionaryWithObject:@"0" forKey:@"result"];
                [NotificationCenterClass postNotificationName:@"wx" object:nil userInfo:dic ];
                
                
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
            }
        }
    }
    
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}





//- (void)registerObserver
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowBecomeKey:) name:UIWindowDidBecomeKeyNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowResignKey:) name:UIWindowDidResignKeyNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowBecomeVisible:) name:UIWindowDidBecomeVisibleNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowBecomeHidden:) name:UIWindowDidBecomeHiddenNotification object:nil];
//}

//- (void)windowBecomeKey:(NSNotification*)noti
//{
//    UIWindow *window = noti.object;
//    NSArray *windows = [UIApplication sharedApplication].windows;
//    NSLog(@"\n\ncurrent window count %d，\n%@", windows.count,windows);
//    NSLog(@"Window has become keyWindow: %@, window level: %f, index of windows: %d", window, window.windowLevel, [windows indexOfObject:window]);
//}
//
//- (void)windowResignKey:(NSNotification*)noti
//{
//    UIWindow *window = noti.object;
//    NSArray *windows = [UIApplication sharedApplication].windows;
//    NSLog(@"\n\ncurrent window count %d，\n%@", windows.count,windows);
//    NSLog(@"Window has Resign keyWindow: %@, window level: %f, index of windows: %d", window, window.windowLevel, [windows indexOfObject:window]);
//}
//
//- (void)windowBecomeVisible:(NSNotification*)noti
//{
//    UIWindow *window = noti.object;
//    NSArray *windows = [UIApplication sharedApplication].windows;
//    NSLog(@"\n\ncurrent window count %d，\n%@", windows.count,windows);
//    NSLog(@"Window has become visible: %@, window level: %f, index of windows: %d", window, window.windowLevel, [windows indexOfObject:window]);
//}
//
//- (void)windowBecomeHidden:(NSNotification*)noti
//{
//    UIWindow *window = noti.object;
//    NSArray *windows = [UIApplication sharedApplication].windows;
//    NSLog(@"\n\ncurrent window count %d，\n%@", windows.count,windows);
//    NSLog(@"Window has become hidden: %@, window level: %f, index of windows: %d", window, window.windowLevel, [windows indexOfObject:window]);
//}


-(void)setNavCtrl
{
    //self.navigationController.navigationBar.hidden=NO;

    //改变所有状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //改变导航栏字体 和 颜色 全局的
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                                           }]; // 设置导航栏字体
    //ios7改变导航栏 背景颜色  全局的
    [[UINavigationBar appearance] setBarTintColor:RGBAColor(68, 166, 242, 1)];
    //改变所有导航栏的背景图片
    //    [[UINavigationBar appearance] setBackgroundImage:LoadBundleImageByName(@"common/com_nav_bg.png") forBarMetrics:UIBarMetricsDefault];
    
    //改变所有导航栏按钮上的字的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    //修改导航栏返回按钮图片
//    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"com_nav_back@2x.png"]];
//    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"com_nav_laji_black.png"]];
    
    //修改导航栏返回按钮图片
    [[UINavigationBar appearance] setBackIndicatorImage:LoadBundleImageByName(@"common/com_nav_back@2x.png")];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:LoadBundleImageByName(@"common/com_nav_back@2x.png")];
}


-(void)testBook
{
    Book *book = [[Book alloc] init];
    book.name = @"c++ primer";
    book.author = @"Stanley B.Lippman";
    book.version = @"5.0";

    NSLog(@"%@", book.name);
    NSLog(@"%@", book.author);
    NSLog(@"%@", book.version);
    
//    程序分析：
//    
//    1）在给程序添加消息转发功能以前，必须覆盖两个方法，即methodSignatureForSelector:和forwardInvocation:。methodSignatureForSelector:的作用在于为另一个类实现的消息创建一个有效的方法签名。forwardInvocation:将选择器转发给一个真正实现了该消息的对象。
//    
//    2）Objective-C中的方法默认被隐藏了两个参数：self和_cmd。self指向对象本身，_cmd指向方法本身。举两个例子来说明：
//    
//    例一：- (NSString *)name
//    
//    这个方法实际上有两个参数：self和_cmd。
//    
//    例二：- (void)setValue:(int)val
//    
//    这个方法实际上有三个参数：self, _cmd和val。
//    
//    被指定为动态实现的方法的参数类型有如下的要求：
//    
//    A.第一个参数类型必须是id（就是self的类型）
//    
//    B.第二个参数类型必须是SEL（就是_cmd的类型）
//    
//    C.从第三个参数起，可以按照原方法的参数类型定义。举两个例子来说明：
//    
//    例一：setHeight:(CGFloat)height中的参数height是浮点型的，所以第三个参数类型就是f。
//    
//    例二：再比如setName:(NSString *)name中的参数name是字符串类型的，所以第三个参数类型就是@

//    3）在上面代码中有一句代码是book.name = @"c++ primer";程序运行到这里时，会去Book.m中寻找setName:这个赋值方法。但是Book.m里并没有这个方法，于是程序进入methodSignatureForSelector:中进行消息转发。执行完之后，以"v@:@"作为方法签名类型返回。
//    
//    这里v@:@是什么东西呢？实际上，这里的第一个字符v代表函数的返回类型是void，后面三个字符参考上面2）中的解释就可以知道，分别是self, _cmd, name这三个参数的类型id, SEL, NSString。
//    
//    接着程序进入forwardInvocation方法。得到的key为方法名称setName:，然后利用[invocationgetArgument:&obj atIndex:2];获取到参数值，这里是“c++ primer”。这里的index为什么要取2呢？如前面分析，第0个参数是self，第1个参数是_cmd，第2个参数才是方法后面带的那个参数。
//    
//    最后利用一个可变字典来赋值。这样就完成了整个setter过程。

//    4）在上面代码中有一句代码是 NSLog(@"%@", book.name);，程序运行到这里时，会去Book.m中寻找name这个取值方法 。但是Book.m里并没有这个取值方法，于是程序进入methodSignatureForSelector:中进行消息转发。执行完之后，以"@@:"作为方法签名类型返回。这里第一字符@代表函数返回类型NSString，第二个字符@代表self的类型id，第三个字符:代表_cmd的类型SEL。
//    
//    接着程序进入forwardInvocation方法。得到的key为方法名称name。最后根据这个key从字典里获取相应的值，这样就完成了整个getter过程。
//    
//    5）注意，调试代码的过程，我们发现只有name和author的赋值和取值进入methodSignatureForSelector:和forwardInvocation:这两个方法。还有一个属性version的赋值和取值，并没有进入methodSignatureForSelector:和forwardInvocation:这两个方法。这是因为，version属性被标识为@synthesize，编译器自动会加上setVersion和version两个方法，所以就不用消息转发了。
}

-(void)appIraterTest
{
//    This example states that the rating request is only shown when the app has been launched 5 times and after 7 days.
    [Appirater setAppId:@"770699556"];
    [Appirater setDaysUntilPrompt:7];
    [Appirater setUsesUntilPrompt:5];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:YES];
    [Appirater appLaunched:YES];
    
////    If you wanted to show the request after 5 days only you can set the following:
//    [Appirater setAppId:@"770699556"];
//    [Appirater setDaysUntilPrompt:5];
//    [Appirater setUsesUntilPrompt:0];
//    [Appirater setSignificantEventsUntilPrompt:-1];
//    [Appirater setTimeBeforeReminding:2];
//    [Appirater setDebug:NO];
//    [Appirater appLaunched:YES];
}

-(void)mtstatusBarTest
{
//    [[MTStatusBarOverlay sharedOverlay] postMessage:@"1" animated:YES];
    [[MTStatusBarOverlay sharedOverlay] postMessage:@"2" duration:2 animated:YES];
    
    [[MTStatusBarOverlay sharedInstance] postErrorMessage:@"error" duration:2];
    [[MTStatusBarOverlay sharedInstance] postFinishMessage:@"success" duration:2];
    
    [[MTStatusBarOverlay sharedInstance] postImmediateMessage:@"ImmediateMessage" duration:2 animated:YES];
}


@end
