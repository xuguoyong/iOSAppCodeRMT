//
//  RMTProductDetailViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTProductDetailViewController.h"
#import "SGControllerTool.h"
#import "RMTBuyHealthCarToolBar.h"

@interface RMTProductDetailViewController ()
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) RMTBuyHealthCarToolBar *toobar;
@end

@implementation RMTProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.toobar = [[RMTBuyHealthCarToolBar alloc] initWithFrame:CGRectMake(0,d_screen_height - 64 - 60, d_screen_width, 60)];
    __weak typeof(self)weakself = self;
    self.toobar.buyButtonClick = ^(id data)
    {
        [weakself buyButtonClick:data];
    };
    [self.view addSubview:self.toobar];
    
    int price =[self.detailModel.quantityList intValue] *[self.detailModel.worth intValue];
    [self.toobar sethealthCarName:[NSString stringWithFormat:@"健康卡%@张",self.detailModel.quantityList] andPrice:[NSString stringWithFormat:@"¥ %d.00",price]];
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    self.webView.sd_layout.topEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.toobar,0);
    NSURL  *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.detailModel.productDetail,self.detailModel.productId]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

/**
 点击购买按钮会调用的方法
 */
- (void)buyButtonClick:(id)data
{
   
    if ([RMTUserInfoModel isUserLogin]) {
        [SGControllerTool popToLoginControllerTarget:self];
    }
}



@end
