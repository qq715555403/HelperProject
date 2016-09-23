//
//  WebviewProgressViewController.h
//  HelperProject
//
//  Created by hushijun on 15/8/14.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebviewProgressViewController : TotalBaseViewController<UIWebViewDelegate, NJKWebViewProgressDelegate>
{
    UIWebView *_webView;
    UIProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property(nonatomic,strong) UIWebView *webView;

@end
