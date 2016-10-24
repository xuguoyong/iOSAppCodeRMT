//
//  SGBaseViewController.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/11.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGBaseViewController.h"
#import "RMTHomePageViewController.h"
#import "RMTHealthCarViewController.h"
#import "RMTAccountViewController.h"
#import "RMTUserInfoViewController.h"
#import "SGControllerTool.h"
#import "RMTLoginViewController.h"
@interface SGBaseViewController ()

@end

@implementation SGBaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    
    if (![self isKindOfClass:[RMTHomePageViewController class]]&&![self isKindOfClass:[RMTHealthCarViewController class]] &&![self isKindOfClass:[RMTHealthCarViewController class]] &&![self isKindOfClass:[RMTAccountViewController class]] &&![self isKindOfClass:[RMTUserInfoViewController class]] ) {
        // 设置导航栏按钮
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"view_leftAndBack_white_icon" highImageName:@"view_leftAndBack_white_icon" target:self action:@selector(leftButtonClickToback:)];
    }
   
 

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self isKindOfClass:[RMTLoginViewController class]] ) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBackWhenUserNeedLoginWithNotification:) name:NotificationUserNeedLogin object:nil];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationUserNeedLogin object:nil];
}


//当用户需要重新登录时，会回调这个方法
- (void)callBackWhenUserNeedLoginWithNotification:(NSNotification *)not
{
    [SGControllerTool popToLoginControllerTarget:self loginSuccessBlock:^(id data) {
        
    }];
    
}

- (void)leftButtonClickToback:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ==如果需要添加tableView 直接调用一下方法即可
/**
 *  是否需要添加tableView
 *
 *  @param delegate tableView的代理
 *
 *  @return 返回一个tableView
 */
- (UITableView *)addTableViewWithDelegate:(id <UITableViewDelegate,UITableViewDataSource>)delegate style:(UITableViewStyle)style
{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:style];
    
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    [self.view addSubview:tableView];
    tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [tableView updateLayout];
    tableView.backgroundColor = viewAndTableViewBackgroundColor;
    tableView.separatorColor = tableViewSeparateColor;
      
    return tableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001f;

}



@end
