//
//  BaseWebViewController.h
//  LYGame
//
//  Created by 花花 on 2017/7/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseUIViewController.h"

@interface BaseWebViewController : BaseUIViewController
//是否需要导航栏  默认是yes
@property (nonatomic, assign)BOOL isNeedNavBar;

@property (nonatomic, strong)UIView * mWebView;
@property (nonatomic, strong)NSArray * forbiddenUrls;
//加载网页
- (void)loadHttpRequestWithUrl:(NSString*)url;
//当前正在加载的地址 子类需要重写
- (BOOL)loadingUrl:(NSString*)url;
//webView加载的进度
- (void)loadPropress:(double)propress;
//加载本地html
- (void)loadLocalHtmlString:(NSString *)htmlContent andBaseURL:(NSURL *)url;
@end
