//
//  BaseWebViewController.h
//  HelperProject
//
//  Created by hushijun on 15/8/15.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WebViewCookieBlock)(void);

@interface BaseWebViewController : TotalBaseViewController<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    UIProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    UIWebView *_webview;
    
    UIButton *_gobackbtn;
    UIBarButtonItem *_left;
}
@property (nonatomic, strong)UIButton *gobackbtn;//直接退出webview的按钮
@property (nonatomic, strong)UIBarButtonItem *left;

@property(nonatomic,strong) UIWebView *webview;

#pragma mark  检测网络并创建Webview
- (void) checkNetWorkAndCreateWebview;

#pragma mark  检测网络并创建Webview没提示信息
- (void) checkNetWorkAndCreateWebviewNoHUD;

#pragma mark  创建Webview
- (void) createWebview;

#pragma mark  创建Webview和进度条视图
- (void) createWebviewAndProgress;

#pragma mark 创建返回首页按钮,webview加载多层之后，直接回到首页的关闭按钮：类似的联通客户端、微信客户端
- (BOOL) createGobackBtn;

#pragma mark  创建cookie
- (void) setCookie;

#pragma mark  设置支付cookie
- (void) setCanpayCookie;

#pragma mark  存储支付cookie
- (void) savePayCookie;

#pragma mark  存储账号地址手机号cookie
- (void) saveNameAddressNumCookie;

#pragma mark  设置进度条和代理方法
- (void) setProgressAndDelegates;

#pragma mark  webview加载url
- (void) webviewLoadRequestWithUrl:(NSString *) strUrl;

#pragma mark  webview加载url
- (void) webviewLoadRequestWithUrl:(NSString *) strUrl andCookieBlock:(WebViewCookieBlock) cookieBlock;

@end
