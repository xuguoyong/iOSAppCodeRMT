//
//  RMTTitianRecordViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTTitianRecordViewController.h"
#import "RMTTitianRecordCell.h"
#import "RMTWinMoneyRecordModel.h"

@interface RMTTitianRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation RMTTitianRecordViewController

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现记录";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTTitianRecordCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self requestDataFromBack];
}


- (void)requestDataFromBack
{

    [RMTDataService getDataWithURL:GET_Win_Money_Record parma:@{@"accountLogType":@"withdraw"} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
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
    return self.dataSource.count +1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMTTitianRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row > 0) {
        RMTWinMoneyRecordModel *model = self.dataSource[indexPath.row -1];
        
        cell.timeLabel.text = model.date;
        cell.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",fabsf([model.money floatValue])];
        
        if ([model.status isEqualToString:@"pendingPayment"]) {
            cell.stauteLabel.text = @"提现中";
        }else if ([model.status isEqualToString:@"alreadyPayment"]){
            cell.stauteLabel.text = @"提现成功";
        }else if ([model.status isEqualToString:@"refusedPayment"])
        {
            cell.stauteLabel.text = @"提现失败";
        }else
        {
            cell.stauteLabel.text = @"未获取到状态信息";
        }
        cell.timeLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.moneyLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.stauteLabel.font = [UIFont systemFontOfSize:14.0f];
        
    }else
    {
        cell.timeLabel.text = @"时间";
        cell.moneyLabel.text = @"金额";
        cell.stauteLabel.text = @"状态";
        
        cell.timeLabel.font = textFont24;
        cell.moneyLabel.font = textFont24;
        cell.stauteLabel.font = textFont24;
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
