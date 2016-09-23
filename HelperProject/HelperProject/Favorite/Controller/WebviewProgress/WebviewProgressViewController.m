//
//  WebviewProgressViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/14.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "WebviewProgressViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebviewProgressViewController ()

@end

@implementation WebviewProgressViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"self.view.frame==%@,kScreen_Height==%lf",NSStringFromCGRect(self.view.frame),kScreen_Height);
    
    
    
//    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height)];
//    [self.view addSubview:_webView];
//
//    _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 2)];
//    _progressView.backgroundColor=[UIColor whiteColor];
//    _progressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);//修改进度条的高度
//    _progressView.trackTintColor=[UIColor whiteColor];
//    [self.view addSubview:_progressView];
//    
//    _progressProxy = [[NJKWebViewProgress alloc] init];
//    _progressProxy.webViewProxyDelegate = self;
//    _progressProxy.progressDelegate = self;
//    _webView.delegate = _progressProxy;
//    
//    
//    [self loadGoogle];
    
    
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,40, kScreen_Width, 300)];
    self.webView.backgroundColor=[UIColor lightGrayColor];
//    NSString *htmlPath=[[NSBundle mainBundle] resourcePath];
//    htmlPath=[htmlPath stringByAppendingPathComponent:@"html/index.html"];
    
    NSString *htmlPath=[MainBundleClass pathForResource:@"index" ofType:@"html"];
    NSURL *localURL=[[NSURL alloc]initFileURLWithPath:htmlPath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:localURL]];
    [self.view addSubview:self.webView];
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    context[@"getIOSVersion"] =[ALHardware getAppShortVersion];
    context[@"getIOSVersion"] = ^() {
        
//        NSLog(@"+++++++Begin Log+++++++");
//        NSArray *args = [JSContext currentArguments];
//        
//        for (JSValue *jsVal in args) {
//            NSLog(@"%@", jsVal);
//        }
//        
//        JSValue *this = [JSContext currentThis];
//        NSLog(@"this: %@",this);
//        NSLog(@"-------End Log-------");
        
        return [ALHardware getAppShortVersion];
        
    };

    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [RequestHelperClass cancelAllRequest];
    
    [_webView cleanForDealloc];
    [_progressView removeFromSuperview];
    _progressView=nil;
    
    self.tabBarController.tabBar.hidden = NO; //隐藏系统tabbar
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES; //隐藏系统tabbar
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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


//- (IBAction)searchButtonPushed:(id)sender
//{
//    [self loadGoogle];
//}
//
//- (IBAction)reloadButtonPushed:(id)sender
//{
//    [_webView reload];
//}

-(void)loadGoogle
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [_webView loadRequest:req];
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
