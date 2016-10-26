//
//  RMTHTMLViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTHTMLViewController.h"

@interface RMTHTMLViewController () <UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation RMTHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [SGShowMesssageTool showLoadingHUDWithErrorMessage:@"网络加载失败"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title=[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [SGShowMesssageTool hideLoadingHUD];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
