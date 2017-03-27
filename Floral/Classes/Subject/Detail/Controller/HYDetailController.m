//
//  HYDetailController.m
//  Floral
//
//  Created by Sekorm on 2017/3/27.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYDetailController.h"
#import <WebKit/WebKit.h>

@interface HYDetailController () <WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;
@end

@implementation HYDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ad_share"] style:UIBarButtonItemStylePlain target:self action:@selector(adShare)];
    
    NSURL *URL = [NSURL URLWithString:self.artcleModel.pageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
    self.navigationItem.title = self.artcleModel.desc;
    
}

- (WKWebView *)webView {
    
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    [self showHint:@"加载失败，请重试" duration:2.0 yOffset:0];
}

- (void)adShare {

}

@end
