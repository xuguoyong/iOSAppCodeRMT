//
//  RMTHomePageViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTHomePageViewController.h"
#import "RMTHomepageModel.h"
#import "RMTHomePageAdCell.h"
#import "RMTHomePageHealthCarThreeTableViewCell.h"
#import "RMTHomePageHealthCarOneTableViewCell.h"

@interface RMTHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
//数据模型
@property (nonatomic,strong) RMTHomepageModel *homePageModel;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation RMTHomePageViewController


#pragma mark ===--viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    [self.tableView registerClass:[RMTHomePageAdCell class] forCellReuseIdentifier:@"advCell"];
    [self.tableView registerClass:[RMTHomePageHealthCarThreeTableViewCell class] forCellReuseIdentifier:@"threeCell"];
     [self.tableView registerClass:[RMTHomePageHealthCarOneTableViewCell class] forCellReuseIdentifier:@"oneCell"];
    [self requestHomepageDataFromBackground];
    __weak typeof(self)weakself = self;
    [self.tableView addRefreshNormalHeaderWithRefreshBlock:^{
        [weakself requestHomepageDataFromBackground];
    }];
    
   
}

#pragma mark =--tabelView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakself = self;
    if (indexPath.section == 0) {
        RMTHomePageAdCell *adv = [tableView dequeueReusableCellWithIdentifier:@"advCell"];
        adv.selectionStyle = UITableViewCellSelectionStyleNone;
        adv.model = self.homePageModel;
        return adv;
    }
    else if (indexPath.section == 1)
    {
        RMTHomePageHealthCarThreeTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"threeCell"];
        threeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        threeCell.model = self.homePageModel;
        threeCell.touchImageViewAction = ^(NSInteger index,RMTProductListModel *model)
        {
            [weakself clickToDetailWithProductModel:model];
        };
        return threeCell;
    }
    
    RMTHomePageHealthCarOneTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
    oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
    oneCell.model = [self.homePageModel.adResponseList objectAtIndex:indexPath.row + 9];
    return oneCell;
    
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        [self clickToDetailWithProductModel:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return d_screen_width *advImagesScale;
    }else if (indexPath.section == 1)
    {
        
        CGFloat itemH = itemW *(250/190.0f);
        return itemH + 20;
    }
    return indexPath.row == 0?(d_screen_width - 20)*(200/600.0f) + 10:(d_screen_width - 20)*(200/600.0f) + 20;
}

#pragma mark --请求数据
- (void)requestHomepageDataFromBackground
{
    __weak typeof(self)weakself = self;
    
    [RMTDataService getDataWithURL:GET_HomePageDataURL parma:nil showErrorMessage:YES showHUD:YES logData:YES success:^(NSDictionary *responseObj) {
        [weakself.homePageModel freeSeleData];
        weakself.homePageModel = nil;
        weakself.homePageModel = [RMTHomepageModel mj_objectWithKeyValues:[responseObj objectForKey:@"data"]];
        [weakself.tableView reloadData];
        [weakself.tableView.mj_header endRefreshing];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
       [weakself.tableView.mj_header endRefreshing];
    }];
}

#pragma mark --= 跳转至页面详情
- (void)clickToDetailWithProductModel:(RMTProductListModel *)model
{
    NSLog(@"%@",model);

    self.tabBarController.selectedIndex = 1;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}



@end
