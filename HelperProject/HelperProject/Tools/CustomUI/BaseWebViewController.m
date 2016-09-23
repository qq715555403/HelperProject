//
//  BaseWebViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/15.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "BaseWebViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "payRequsestHandler.h"
#import "WXApi.h"

@interface BaseWebViewController ()

@end

@implementation BaseWebViewController

- (void)dealloc{
    [_webview cleanForDealloc];
    _webview = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    //2015-08-15 17:30:38 add by 胡仕君：在父类中也增加如下代码
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载 ，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
        {
            // Add code to preserve data stored in the views that might be
            // needed later.
            
            // Add code to clean up other strong references to the view in
            // the view hierarchy.
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 子类网络失败图片点击手势事件
-(void)imgLostConnectTaped:(UITapGestureRecognizer *)tap
{
    [super imgLostConnectTaped:tap];
    
    [self checkNetWorkAndCreateWebview];
}

#pragma mark  检测网络并创建Webview
- (void) checkNetWorkAndCreateWebview
{
    [self checkNetWorkAndCreateWebviewWithTag:@"1"];
}

#pragma mark  检测网络并创建Webview没提示信息
- (void) checkNetWorkAndCreateWebviewNoHUD
{
    [self checkNetWorkAndCreateWebviewWithTag:@"0"];
}

#pragma mark  检测网络并创建Webview没提示信息
/**
 *  防止像我的订单页面，有自动网络请求登录成功之后才创建webview内容，hud提示信息会在网络请求的时候就加上
 *
 *  @param strTag 1-展现提示信息 0-不展示
 */
- (void) checkNetWorkAndCreateWebviewWithTag:(NSString *) strTag
{
    BOOL isconnect=[RequestHelper checkNetwork:NetErrorInfo];
    if (isconnect) {
        
        [self hideImageWithLostConnect];
        [self createWebview];
        if ([strTag isEqualToString:@"1"]) {
            [CPToast addMBProgressHUD:@"加载中..." toView:self.view];
        }
    }else{
        [self createImageWithLostConnect];
    }
}


#pragma mark  创建Webview
- (void)createWebview{
    NSLog(@"BaseWebViewController------createWebview");
}

#pragma mark  webview加载url
- (void) webviewLoadRequestWithUrl:(NSString *) strUrl
{
    //    _webview
    //清除webview缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
//    NSString *str = @"http://wx.leleda.com/wapios/newrepair/iphoneModel.php";
//    [self setCookie];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:WebViewTimeoutInterval];
    [_webview loadRequest:request];
}

#pragma mark  webview加载url
- (void) webviewLoadRequestWithUrl:(NSString *) strUrl andCookieBlock:(WebViewCookieBlock) cookieBlock
{
    //    _webview
    //清除webview缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
//    cookieBlock;
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:WebViewTimeoutInterval];
    [_webview loadRequest:request];
}

#pragma mark  创建Webview和进度条视图
- (void) createWebviewAndProgress{
    if (_webview==nil) {
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64 )];
        [self.view addSubview:_webview];
        
        _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,2)];
        _progressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);//修改进度条的高度
        _progressView.progressTintColor=RGBAColor(15, 174, 110, 1);
        _progressView.trackTintColor=[UIColor whiteColor];
        _progressView.backgroundColor=[UIColor whiteColor];
        //    _progressView.trackTintColor=[UIColor redColor];
        [self.view addSubview:_progressView];
    }
    
    //2015-08-15 15:54:05 add by 胡仕君：增加webview加载进度条
    [self setProgressAndDelegates];
}

#pragma mark - 设置进度条和代理方法
- (void) setProgressAndDelegates
{
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    _webview.delegate = _progressProxy;
}

#pragma mark - 父类webview成功代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [CPToast hiddenMBProgressHUDForView:self.view];
    
    //防止内存暴涨
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
#pragma mark  父类webview失败代理方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [CPToast hiddenMBProgressHUDForView:self.view];
    
    if ([error code] == NSURLErrorCancelled){
        return;
    }
    
    NSString *strError=error.localizedDescription;
    [self createImageWithLostConnectWithErrorInfo:strError];
}

#pragma mark 创建返回首页按钮
- (BOOL)createGobackBtn{
    //创建直接退出按钮
    if ([_webview canGoBack] == YES) {
        if (!_gobackbtn) { //关闭按钮不存在时创建
            self.gobackbtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 25, 30, 30)];
            [_gobackbtn setImage:LoadBundleImageByName(@"common/com_nav_close@2x.png") forState:UIControlStateNormal];
            [_gobackbtn addTarget:self action:@selector(gobackBtnAction) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *leftback = [[UIBarButtonItem alloc]initWithCustomView:_gobackbtn];
            
            NSArray *arr = [NSArray arrayWithObjects:_left,leftback, nil];
            
            [self.navigationItem setLeftBarButtonItems:arr];
        }
        return YES;
    }else{
        return NO;
    }
}

- (void)gobackBtnAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - 创建cookie
- (void)setCookie{
    //第一条cookie
    NSMutableDictionary *cookiePropertiesUser = [NSMutableDictionary dictionary];
    [cookiePropertiesUser setObject:@"fx-address" forKey:NSHTTPCookieName];
    NSString *add = [[NSUserDefaults standardUserDefaults] objectForKey:@"fx-address"];
    if ([[add stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return;
    }
    NSString *url1 = add;
    NSString *urla1 = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSLog(@"urla = %@",url1);
    [cookiePropertiesUser setObject:urla1 forKey:NSHTTPCookieValue];
    [cookiePropertiesUser setObject:@"wx.leleda.com" forKey:NSHTTPCookieDomain];
    [cookiePropertiesUser setObject:@"/wapios/newrepair" forKey:NSHTTPCookiePath];
    [cookiePropertiesUser setObject:@"0" forKey:NSHTTPCookieVersion];
    //第二条cookie
    NSMutableDictionary *cookiePropertiesUser1 = [NSMutableDictionary dictionary];
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"fx-username"];
    NSString *url = name;
    NSString *urla = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [cookiePropertiesUser1 setObject:@"fx-username" forKey:NSHTTPCookieName];
    [cookiePropertiesUser1 setObject:urla forKey:NSHTTPCookieValue];
    [cookiePropertiesUser1 setObject:@"wx.leleda.com" forKey:NSHTTPCookieDomain];
    [cookiePropertiesUser1 setObject:@"/wapios/newrepair" forKey:NSHTTPCookiePath];
    [cookiePropertiesUser1 setObject:@"0" forKey:NSHTTPCookieVersion];
    // 第三条cookie
    NSMutableDictionary *cookiePropertiesUser2 = [NSMutableDictionary dictionary];
    [cookiePropertiesUser2 setObject:@"phoneNum" forKey:NSHTTPCookieName];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNum"];
    NSString *p = phone;
    NSString *pp = [p stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cookiePropertiesUser2 setObject:pp forKey:NSHTTPCookieValue];
    [cookiePropertiesUser2 setObject:@"wx.leleda.com" forKey:NSHTTPCookieDomain];
    [cookiePropertiesUser2 setObject:@"/wapios/newrepair" forKey:NSHTTPCookiePath];
    [cookiePropertiesUser2 setObject:@"0" forKey:NSHTTPCookieVersion];
    //保存cookie
    [cookiePropertiesUser setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    [cookiePropertiesUser1 setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    [cookiePropertiesUser2 setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    //重新设置cookie内容
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser];
    NSHTTPCookie *cookieuser1 = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser1];
    NSHTTPCookie *cookieuser2 = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser2];
    
    // 将新的cookie加入
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser1];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser2];
    
}

#pragma mark  设置支付cookie
- (void)setCanpayCookie{
    
    
    NSLog(@"设置cookie");
    //第四条cookie
    NSMutableDictionary *cookiePropertiesUser3 = [NSMutableDictionary dictionary];
    [cookiePropertiesUser3 setObject:@"canPay" forKey:NSHTTPCookieName];
    NSString *pay = [[NSUserDefaults standardUserDefaults] objectForKey:@"canPay"];
    NSString *p1 = pay;
        NSLog(@"p1 = %@",p1);
    NSString *ppay = [p1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"ppay = %@",ppay);
    [cookiePropertiesUser3 setObject:ppay forKey:NSHTTPCookieValue];
    [cookiePropertiesUser3 setObject:@"wap.leleda.com" forKey:NSHTTPCookieDomain];
    [cookiePropertiesUser3 setObject:@"/wapios/newrepair" forKey:NSHTTPCookiePath];
    [cookiePropertiesUser3 setObject:@"0" forKey:NSHTTPCookieVersion];
    
    
    NSNumber *nub = [NSNumber numberWithBool:FALSE];
    
    
    
    [cookiePropertiesUser3 setObject:nub forKey:NSHTTPCookieSecure];
    
    [cookiePropertiesUser3 setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie *cookieuser3 = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser3];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser3];
}


#pragma mark  存储支付cookie
- (void) savePayCookie
{
    //截取cookie并且保存的本地
    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [myCookie cookies]) {
        
//                NSLog(@"cookie = %@",cookie);
        
        if ([cookie.name  isEqualToString:@"fx-username"]) {
            [[NSUserDefaults standardUserDefaults] setObject:[cookie.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"fx-username"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if ([cookie.name isEqualToString:@"fx-address"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[cookie.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"fx-address"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if ([cookie.name  isEqualToString:@"phoneNum"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[cookie.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"phoneNum"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        if ([cookie.name  isEqualToString:@"canPay"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[cookie.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"canPay"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}


#pragma mark  存储账号地址手机号cookie
- (void) saveNameAddressNumCookie
{
    //截取cookie并且保存的本地
    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [myCookie cookies]) {
        
        //        NSLog(@"cookie = %@",cookie);
        if ([cookie.name  isEqualToString:@"fx-username"]) {
            [[NSUserDefaults standardUserDefaults] setObject:[cookie.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"fx-username"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if ([cookie.name isEqualToString:@"fx-address"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[cookie.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"fx-address"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if ([cookie.name  isEqualToString:@"phoneNum"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[cookie.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"phoneNum"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        _progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            _progressView.alpha = 1.0;
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
            _progressView.alpha = 0.0;
        } completion:nil];
    }
    
    [_progressView setProgress:progress animated:NO];
}


@end
