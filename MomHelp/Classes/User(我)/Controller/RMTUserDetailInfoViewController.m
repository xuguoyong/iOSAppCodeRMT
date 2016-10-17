//
//  RMTUserDetailInfoViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//  用户的详细信息

#import "RMTUserDetailInfoViewController.h"
#import "RMTUserInfoHeadCell.h"
@interface RMTUserDetailInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSources;
@end

@implementation RMTUserDetailInfoViewController

-(NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [[NSMutableArray alloc] init];
        [_dataSources addObject:@[@"头像",@"昵称",@"手机",@"性别",@"生日",@"地区"]];
        [_dataSources addObject:@[@"实名认证",@"绑定银行卡",@"交易密码"]];
    }
    return _dataSources;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"个人资料";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTUserInfoHeadCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSources.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *ar = self.dataSources[section];
    return ar.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 &&indexPath.row == 0) {
        return 70.0f;
    }
    return 50.0f;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 &&indexPath.row == 0) {
        RMTUserInfoHeadCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        headCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return headCell;
    }
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.detailTextLabel.text  =@"显示详情的信息";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.f];
    }
    cell.textLabel.text =self.dataSources [indexPath.section][indexPath.row];
    return cell;


}
@end
