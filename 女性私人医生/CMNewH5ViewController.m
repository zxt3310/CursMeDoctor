//
//  CMNewH5ViewController.m
//  女性私人医生
//
//  Created by Zxt on 2020/7/10.
//  Copyright © 2020 Tim. All rights reserved.
//

#import "CMNewH5ViewController.h"
#import <WebKit/WebKit.h>

@interface CMNewH5ViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation CMNewH5ViewController
{
    WKWebView *h5View;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isMainPage = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    h5View = [[WKWebView alloc] initWithFrame:self.view.bounds];
    h5View.navigationDelegate = self;
    h5View.UIDelegate = self;
    [self.view addSubview:h5View];
    
    [h5View loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    
    if (self.isMainPage) {
        self.tabBarController.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id obj,NSError *err){
        if([obj isKindOfClass:[NSString class]]){
            self.tabBarController.navigationItem.title = (NSString*)obj;
            self.title = (NSString*)obj;
        }
    }];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if(navigationAction.sourceFrame == nil){
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        CMNewH5ViewController *web = [[CMNewH5ViewController alloc] init];
        web.urlStr = navigationAction.request.URL.absoluteString;
        [self.navigationController pushViewController:web animated:YES];
         decisionHandler(WKNavigationActionPolicyCancel);

    }
}


@end
