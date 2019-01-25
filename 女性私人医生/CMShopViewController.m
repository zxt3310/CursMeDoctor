//
//  CMShopViewController.m
//  女性私人医生
//
//  Created by 张信涛 on 2019/1/21.
//  Copyright © 2019年 Tim. All rights reserved.
//

#import "CMShopViewController.h"
#import <WebKit/WebKit.h>

@interface CMShopViewController ()<WKNavigationDelegate>

@end

@implementation CMShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - FitIpX(130))];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mall.ranknowcn.com/html/mall.html?type=19022967&app=1"]]];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.leftBarButtonItems = nil;
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
    self.tabBarController.navigationItem.title = @"优品商城";
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSURL *url = navigationAction.request.URL;
    if ([url.absoluteString isEqualToString:@"http://mall.ranknowcn.com/html/mall.html?type=19022967&app=1"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    [[UIApplication sharedApplication] openURL:url];
    
    decisionHandler(WKNavigationActionPolicyCancel);
}
@end
