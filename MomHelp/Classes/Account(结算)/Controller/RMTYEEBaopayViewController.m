//
//  RMTYEEBaopayViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/21.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTYEEBaopayViewController.h"

@interface RMTYEEBaopayViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation RMTYEEBaopayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  =@"易宝支付";
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [SGShowMesssageTool showLoadingHUD];
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SGShowMesssageTool showLoadingHUDWithErrorMessage:@"网络家加载失败"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title=[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [SGShowMesssageTool hideLoadingHUD];
    
}



@end
