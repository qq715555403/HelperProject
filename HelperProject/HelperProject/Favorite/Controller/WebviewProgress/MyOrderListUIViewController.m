//
//  ReallyExampleUIViewController.m
//  demo
//
//  Created by fx-fengyi-shen on 14/10/23.
//  Copyright (c) 2014年 fx-fengyi-shen. All rights reserved.
//

#import "MyOrderListUIViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "PapsuccessViewController.h"

@interface MyOrderListUIViewController ()
@property WebViewJavascriptBridge* bridge;
@property (nonatomic, copy)NSString *currentURL;
@property (nonatomic, assign)BOOL no;
@property (nonatomic, strong)UIImageView *lostconnect;
//预支付订单的数据
@property (nonatomic, copy)NSString *body;
@property (nonatomic, copy)NSString *detail;
@property (nonatomic, copy)NSString *outtradeno;
@property (nonatomic, copy)NSString *notifyurl;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, assign)BOOL cangomainpage;
@end
@implementation MyOrderListUIViewController


- (void)buttonAction:(UIBarButtonItem *)sender{
//    NSLog(@"currl = %@",_currentURL);
    //判断是否直接返回主页面
    if([_currentURL rangeOfString:@"viewOrder.php"].location !=NSNotFound)
    {
        //        NSLog(@"yes");
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else
    {
        //        NSLog(@"no");
    }
    
    if([_currentURL rangeOfString:@"payOver.php"].location !=NSNotFound)
    {
        //        NSLog(@"yes");
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else
    {
        //        NSLog(@"no");
    }
    if (_cangomainpage) {
        
        if([_currentURL rangeOfString:@"repairDetail.php"].location !=NSNotFound)
        {
            //        NSLog(@"yes");
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        else
        {
            //        NSLog(@"no");
        }

    }
    
    
    [_webview goBack];
    if ([_webview canGoBack] == NO) {
        [self.navigationController popViewControllerAnimated:YES];
    }


}
#pragma mark - 微信支付返回结果
- (void)wxcenter:(NSNotification *)not{
    
    
    __weak MyOrderListUIViewController *vc = self;
    
//    NSLog(@"通知中心成功通知");
    NSDictionary *result =     not.userInfo;
    
    if ([[result objectForKey:@"result"] isEqualToString:@"1"]) {

        [self.webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"checkPay_wx('%@');",@"1"]];
        
        [self.webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"checkPay('%@','%@');",@"1",@"wx"]];

        [_bridge registerHandler:@"paySuccess" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSDictionary*strMessage = (NSDictionary*)data;
//            NSLog(@"strmessage = %@",strMessage);
            
            
            PapsuccessViewController *pay = [[PapsuccessViewController alloc]init];
            pay.url = [strMessage objectForKey:@"url"];
            
            [vc.navigationController pushViewController:pay animated:YES];
            
        }];

    } else {
        [self.webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"checkPay_wx('%@');",@"0"]];
        
        [self.webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"checkPay('%@','%@');",@"0",@"wx"]];


        _cangomainpage = YES;
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //设置cookie
    [[NSUserDefaults standardUserDefaults] setObject:[@"yes" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"canPay"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //设置标题
    self.title = @"我的订单";
    //改变导航栏左侧按钮
    _left = [[UIBarButtonItem alloc]initWithImage:LoadBundleImageByName(@"common/com_nav_back@2x.png") style:UIBarButtonItemStylePlain target:self action:@selector(buttonAction:)];
    self.navigationItem.leftBarButtonItem = _left;
    
    //修改webview的UA
    NSDictionary *dictionary = @{@"UserAgent": @"iphone-leleda"};
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    //注册微信支付返回结果的通知中心
    [NotificationCenterClass addObserver:self selector:@selector(wxcenter:) name:@"wx" object:nil];

    self.cangomainpage = NO;
    
    //2015-08-17 10:57:57 by 胡仕君：网络请求自动登录
    [self requestLogin];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [RequestHelperClass cancelAllRequest];
    
    self.tabBarController.tabBar.hidden = NO; //隐藏系统tabbar
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES; //隐藏系统tabbar
}

#pragma mark 网络请求自动登录
-(void) requestLogin
{
    [CPToast addMBProgressHUD:@"加载中..." toView:self.view];
    
    //如果有密码和账号就自动登陆
    NSString *password = [UserDefaultClass objectForKey:@"password"];
    NSString *phone = [UserDefaultClass objectForKey:@"iphone"];
    
    NSString *password1 = @"";
    NSString *phone1 = @"";
    
    if ([NSString isEmptyOfString:phone]==NO) {
        phone1 = phone;
    }
    
    if ([NSString isEmptyOfString:password]==NO) {
        password1 = password;
    }
    
    [RequestHelperClass postWithUrl:@"http://wap.leleda.com/sell/recv/Login.php" param:@{@"phoneNum":phone1,@"passWord":password1} success:^(NSDictionary *results, NSData *data) {
        
        //        NSLog(@"results = %@",results);
        [self checkNetWorkAndCreateWebviewNoHUD];
        
    } failure:^(NSDictionary *results, NSError *error) {
        
        [CPToast hiddenMBProgressHUDForView:self.view];
        [self createImageWithLostConnect];
    }];

}



#pragma mark - 子类网络失败图片点击手势事件
-(void)imgLostConnectTaped:(UITapGestureRecognizer *)tap
{
    NSLog(@"%s,imgLostConnectTaped",__func__);
    
    [self hideImageWithLostConnect];
    [self requestLogin];
}



- (void)createWebview
{
    __weak   MyOrderListUIViewController *vc = self;
    
    //2015-08-15 16:09:53 add by 胡仕君：创建webview和进度条
    [self createWebviewAndProgress];
    
    if (!_bridge){
        
        _bridge = [WebViewJavascriptBridge bridgeForWebView:_webview webViewDelegate:_progressProxy handler:^(id data, WVJBResponseCallback responseCallback) {
            NSString*strMessage = (NSString*)data;
            NSData*jsonData = [strMessage dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary* jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:nil];
            NSString *uuu = [jsonObject objectForKey:@"phone"];
            //将返回的号码存入本地
            NSString *uid = [jsonObject objectForKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:uuu forKey:@"iphone"];
            [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            responseCallback(@"");
            
        }];
    }
    //        支付宝支付********************************************************************************************
    [_bridge registerHandler:@"alipay" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary*strMessage = (NSDictionary*)data;
        //            NSData*jsonData = [strMessage dataUsingEncoding:NSUTF8StringEncoding];
        //            NSDictionary* jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
        //                                                                       options:NSJSONReadingAllowFragments
        //                                                                         error:nil];
        //            NSLog(@"调用支付");
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"cn.leleda.Leleda";
        NSString *str = [strMessage objectForKey:@"str"];
        //调用支付宝
        [[AlipaySDK defaultService] payOrder:str fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            if ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000) {
                
                //调用js 方法
                [self.webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"checkPay('%@','%@');",@"1",@"zfb"]];
                
                [_bridge registerHandler:@"paySuccess" handler:^(id data, WVJBResponseCallback responseCallback) {
                    NSDictionary*strMessage = (NSDictionary*)data;
//                    NSLog(@"strmessage = %@",strMessage);
                    
                    
                    PapsuccessViewController *pay = [[PapsuccessViewController alloc]init];
                    pay.url = [strMessage objectForKey:@"url"];
                    
                    [vc.navigationController pushViewController:pay animated:YES];
                    
                }];
            }  else {
                //调用js 方法
                
                [self.webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"checkPay('%@','%@');",@"0",@"zfb"]];
                
                _cangomainpage = YES;
                
                
            }
        }];
    }];
    //微信支付**********************************************************************************************
    [_bridge registerHandler:@"wxpay" handler:^(id data, WVJBResponseCallback responseCallback) {
        //解析数据
        
        NSData *jsonData=[data dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
        _body = dic[@"body"];
        _detail = dic[@"detail"];
        _notifyurl = dic[@"notify_url"];
        _outtradeno = dic[@"out_trade_no"];
        _price = [NSString stringWithFormat:@"%@",dic[@"total_fee"]];
        
        NSLog(@"_price = %@",dic[@"total_fee"]);
        //
        [WXApi registerApp:APP_ID withDescription:@"leleda"];
        //先判断用户手机是否安装了微信
        if ([WXApi isWXAppInstalled] == YES) {
            
            
            [self sendPay_demo];
            
        } else {
            [self.webview stringByEvaluatingJavaScriptFromString:@"no_WX()"];
            
            //提示用户安装
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注意" message:@"您的手机没有安装微信！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            
            [self.view addSubview:alert];
            [alert show];
            
            
        }
        
    }];
    //获取登陆的用户名和密码*************************************************************************************
    [_bridge registerHandler:@"getphoneanduid" handler:^(id data, WVJBResponseCallback responseCallback) {
        //            NSString*strMessage = (NSString*)data;
        //            NSData*jsonData = [strMessage dataUsingEncoding:NSUTF8StringEncoding];
        //            NSDictionary* jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
        //                                                                       options:NSJSONReadingAllowFragments
        //                                                                         error:nil];
        
        
        NSLog(@"获取密码和账户");
        NSDictionary*strMessage = (NSDictionary*)data;
        NSLog(@"%@",strMessage);
        [[NSUserDefaults standardUserDefaults] setObject:[strMessage objectForKey:@"phone"] forKey:@"iphone"];
        [[NSUserDefaults standardUserDefaults] setObject:[strMessage objectForKey:@"password"] forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }];
//    //分享宝贝******************************************************************************************
//    [_bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
//        
//        
//        NSDictionary*url = (NSDictionary*)data;
//        
//        
//        
//        
//        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"108" ofType:@"png"];
//        [ShareSDK connectWeChatWithAppId:@"wx0bb7f5b66848f59c"
//                               wechatCls:[WXApi class]];
//        //构造分享内容
//        id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"只要%@元，隔壁老王都在乐乐达下单了，快来看看吧~",[url objectForKey:@"price"]]
//                                           defaultContent:@"想省钱怕被骗的都快来瞅瞅，手机就该玩得起也修的起~"
//                                                    image:[ShareSDK imageWithPath:imagePath]
//                                                    title:[url objectForKey:@"name"]
//                                                      url:[url objectForKey:@"url"]
//                                              description:nil
//                                                mediaType:SSPublishContentMediaTypeNews];
//        //创建弹出菜单容器
//        id<ISSContainer> container = [ShareSDK container];
//        //            [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionUp];
//        
//        //弹出分享菜单
//        [ShareSDK showShareActionSheet:container
//                             shareList:nil
//                               content:publishContent
//                         statusBarTips:YES
//                           authOptions:nil
//                          shareOptions:nil
//                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                    
//                                    if (state == SSResponseStateSuccess)
//                                    {
//                                        NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"),nil);
//                                    }
//                                    else if (state == SSResponseStateFail)
//                                    {
//                                        NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
//                                    }
//                                }];
//        
//    }];

    
    //清除webview缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //设置cookie
    NSMutableDictionary *cookiePropertiesUser3 = [NSMutableDictionary dictionary];
    [cookiePropertiesUser3 setObject:@"canPay" forKey:NSHTTPCookieName];
    [cookiePropertiesUser3 setObject:@"yes" forKey:NSHTTPCookieValue];
    [cookiePropertiesUser3 setObject:@"wx.leleda.com" forKey:NSHTTPCookieDomain];
    [cookiePropertiesUser3 setObject:@"/" forKey:NSHTTPCookiePath];
    [cookiePropertiesUser3 setObject:@"0" forKey:NSHTTPCookieVersion];
    [cookiePropertiesUser3 setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    NSHTTPCookie *cookieuser3 = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser3];
    //加入cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser3];
    //加载请求
    
    NSURL *url = [NSURL URLWithString:@"http://news.baidu.com"];
//    NSURL *url = [NSURL URLWithString:@"http://wap.leleda.com/sell/view_order.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
    
}
#pragma mark - 微信支付过程
- (void)sendPay_demo
{

    NSLog(@"开始支付");
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    
//    NSLog(@"price = %@",[dict1 objectForKey:@"total_fee"]);
    //设置预支付的参数
    req.body = _body;
    req.detail = _detail;
    req.outtradeno = _outtradeno;
    req.notifyurl = _notifyurl;
    req.price = _price;
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        //        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
//        NSLog(@"dict = %@",[dict objectForKey:@"package"]);
        //用这个方法才会调起微信支付
        [WXApi safeSendReq:req];

        
    }
    

    
}

//内存整理
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    
    //截取当前加载的网址的url
    self.currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    //
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    //创建直接退出按钮
    [self createGobackBtn];
    
    //2015-08-15 15:58:44 update by 胡仕君：将cookie代码移到webview基类中
    [self savePayCookie];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
