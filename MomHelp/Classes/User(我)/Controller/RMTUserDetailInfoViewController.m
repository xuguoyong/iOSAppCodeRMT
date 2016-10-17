//
//  RMTUserDetailInfoViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//  用户的详细信息

#import "RMTUserDetailInfoViewController.h"

@interface RMTUserDetailInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation RMTUserDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"个人资料";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
}

@end
