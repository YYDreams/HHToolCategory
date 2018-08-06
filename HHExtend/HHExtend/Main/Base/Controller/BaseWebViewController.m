//
//  BaseWebViewController.m
//  LYGame
//
//  Created by 花花 on 2017/7/15.
//  Copyright © 2017年 花花. All rights reserved.
//

//webview到顶部的距离
#define TOP_MARGIN (self.isNeedNavBar?0:20)

#import "BaseWebViewController.h"
#import <WebKit/WebKit.h>
@interface BaseWebViewController ()< UIWebViewDelegate, WKNavigationDelegate,WKUIDelegate,NSURLConnectionDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) WKWebView *wkWebView;

@end

@implementation BaseWebViewController

- (void)dealloc
{
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_wkWebView removeObserver:self forKeyPath:@"title"];
    _wkWebView.navigationDelegate = nil;
    _wkWebView.UIDelegate = nil;
}
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.isNeedNavBar = YES;
    }
    return self;
}
- (UIWebView*)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,TOP_MARGIN, Screen_Width, Screen_Height-TOP_MARGIN-(self.isNeedNavBar?64:0))];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = YES;
        _webView.scrollView.bounces = NO;
        _webView.scalesPageToFit = YES;
        [self.view addSubview:_webView];
    }
    
    return _webView;
}
- (WKWebView * )wkWebView
{
    if (!_wkWebView)
    {
        //网页自适应屏幕的大小
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        WKUserContentController * userContent = [[WKUserContentController alloc]init];
        
        [userContent addUserScript:wkUScript];
        
        WKWebViewConfiguration *configuretion = [[WKWebViewConfiguration alloc] init];
        
        configuretion.userContentController = userContent;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,TOP_MARGIN, Screen_Width,Screen_Height-TOP_MARGIN-(self.isNeedNavBar?64:0)) configuration:configuretion];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        [self.view addSubview:_wkWebView];
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return _wkWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadHttpRequestWithUrl:(NSString*)url
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    self.mWebView = self.wkWebView;

}

- (void)loadLocalHtmlString:(NSString *)htmlContent andBaseURL:(NSURL *)url{
    self.mWebView = self.wkWebView;
    [self.wkWebView loadHTMLString:htmlContent baseURL:url];
    
}

#pragma mark - webViewDelegate
//这个方法可以拦截到加载网页的URL
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * urlStr = request.URL.absoluteString;
    BOOL isAllow = YES;
    
    if ([urlStr hasPrefix:@"http://"]||[urlStr hasPrefix:@"https://"])
    {
        isAllow = [self loadingUrl:urlStr];
    }
    
    return isAllow;
}
//网页加载完成的回调
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    
}
//网页加载失败的回调
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


#pragma mark - WKWebViewDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{ // 类似 UIWebView 的 －webViewDidFinishLoad:
    NSLog(@"didFinishNavigation");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    // 类似 UIWebView 的- webView:didFailLoadWithError:
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    BOOL isAllow = YES;
    if ([self.forbiddenUrls containsObject:urlStr]) {
        isAllow = NO;
        
    }
    else
    {
        if ([urlStr hasPrefix:@"http://"]||[urlStr hasPrefix:@"https://"])
        {
            isAllow = [self loadingUrl:urlStr];
        }
    }
    
    
    decisionHandler(isAllow);
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{ // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    // 创建 NSURLCredential 对象
    NSURLCredential *newCred = [NSURLCredential credentialWithUser:@"123"
                                                          password:@"123"
                                                       persistence:NSURLCredentialPersistenceNone];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

//WkWebView的progress 回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"estimatedProgress"])
    {
        double estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
        
        [self loadPropress:estimatedProgress];
    }else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.wkWebView) {
        self.title = self.wkWebView.title;
         } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
         }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    }
    
}



- (BOOL)loadingUrl:(NSString *)url
{
    return YES;
}

- (void)loadPropress:(double)propress
{
    
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

@end
