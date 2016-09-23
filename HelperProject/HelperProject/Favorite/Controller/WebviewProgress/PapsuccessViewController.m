//
//  PapsuccessViewController.m
//  demo
//
//  Created by fx-fengyi-shen on 15/6/11.
//  Copyright (c) 2015年 fx-fengyi-shen. All rights reserved.
//

#import "PapsuccessViewController.h"
#import "WebViewJavascriptBridge.h"
@interface PapsuccessViewController ()
@property (nonatomic, strong)UIWebView *webview;

@property WebViewJavascriptBridge* bridge;
@end

@implementation PapsuccessViewController


- (void)backmainpage{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:LoadBundleImageByName(@"common/com_nav_back@2x.png") style:UIBarButtonItemStylePlain target:self action:@selector(backmainpage)];
    self.navigationItem.leftBarButtonItem = left;
    
    [self checkNetWorkAndCreateWebview];
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


#pragma mark - 子类网络失败图片点击手势事件
-(void)imgLostConnectTaped:(UITapGestureRecognizer *)tap
{
    [super imgLostConnectTaped:tap];
    
    [self checkNetWorkAndCreateWebview];
}


- (void) checkNetWorkAndCreateWebview
{
    BOOL isconnect=[RequestHelper checkNetwork:NetErrorInfo];
    if (isconnect) {
        
        [self hideImageWithLostConnect];
        [self createWebview];
        [CPToast addMBProgressHUD:@"加载中..." toView:self.view];
    }else{
        [self createImageWithLostConnect];
    }
}

- (void)createWebview
{
    
    
    
    __block  PapsuccessViewController *vc = self;
    if (_webview==nil) {
        self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64)];
        _webview.delegate=self;
        [self.view addSubview:_webview];
        if (!_bridge){
            
            _bridge = [WebViewJavascriptBridge bridgeForWebView:_webview webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
                NSString*strMessage = (NSString*)data;
                NSData*jsonData = [strMessage dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary* jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                           options:NSJSONReadingAllowFragments
                                                                             error:nil];
     
                responseCallback(@"");
                
            }];
        }
        
        [_bridge registerHandler:@"gohomepage" handler:^(id data, WVJBResponseCallback responseCallback) {
            
            [vc.navigationController popToRootViewControllerAnimated:YES];
            
        }];
        
        
        
        
    }
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
    
    
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [CPToast hiddenMBProgressHUDForView:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [CPToast hiddenMBProgressHUDForView:self.view];
    
    if ([error code] == NSURLErrorCancelled){
        return;
    }
    
    NSString *strError=error.localizedDescription;
    [self createImageWithLostConnectWithErrorInfo:strError];
}

@end
