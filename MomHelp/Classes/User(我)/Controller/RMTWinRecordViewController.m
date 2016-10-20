//
//  RMTWinRecordViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTWinRecordViewController.h"
#import "RMTWinMoneyCell.h"
#import "RMTWinMoneyRecordModel.h"
@interface RMTWinRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation RMTWinRecordViewController

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收益记录";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTWinMoneyCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self requestDataFromBack];
}


- (void)requestDataFromBack
{
    
    [RMTDataService getDataWithURL:GET_Receve_Money_Record parma:@{@"accountLogType":@"withdraw"} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        self.dataSource = [RMTWinMoneyRecordModel mj_objectArrayWithKeyValuesArray:[responseObj objectForKey:@"data"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMTWinMoneyRecordModel *model = self.dataSource[indexPath.row];
    RMTWinMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:defultHeadName]];
    cell.nameLabel.text = model.nick;
    cell.timeLabel.text = model.date;
    cell.moneyLabel.text = model.money;
    return cell;
}

@end
