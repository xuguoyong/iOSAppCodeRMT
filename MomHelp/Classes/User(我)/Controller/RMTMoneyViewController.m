//
//  RMTMoneyViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTMoneyViewController.h"
#import "RMTMoneyHeaderCell.h"
#import "RMTReceveMoneyListCell.h"
#import "RMTMoneyModel.h"

@interface RMTMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) RMTMoneyModel *dataModel;


@end

@implementation RMTMoneyViewController
-(NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [[NSMutableArray alloc] init];
    }
    return _dataSources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"钱包";
    self.tableView  = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    self.tableView.separatorColor = UIColorFromRGB(0xd2d2d2);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTMoneyHeaderCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTReceveMoneyListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    __weak typeof(self)weakself =self;
    [self.tableView addRefreshNormalHeaderWithRefreshBlock:^{
        [weakself requestDataFromBack];
    }];
    [self requestDataFromBack];
    
}
- (void)requestDataFromBack
{
    
    [RMTDataService getDataWithURL:GET_Money_Packgae parma:nil showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        
      self.dataModel = [RMTMoneyModel mj_objectWithKeyValues:[responseObj objectForKey:@"data"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
    [RMTDataService getDataWithURL:GET_Money_ResentMoneyList parma:nil showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        
        //        self.dataModel = [RMTMainFriendModel mj_objectWithKeyValues:[responseObj objectForKey:@"data"]];
        [self.dataSources removeAllObjects];
        for (NSDictionary *dic in [responseObj objectForKey:@"data"]) {
            RMTMoneyModel *model = [RMTMoneyModel mj_objectWithKeyValues:dic];
            [self.dataSources addObject:model];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    return self.dataSources.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0001f;
    }
    return 25.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200.0f;
    }
    return 65.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    if (indexPath.section == 0) {
        
      RMTMoneyHeaderCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        headCell.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[self.dataModel.balance floatValue]];
        return headCell;
    }
     RMTReceveMoneyListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    RMTMoneyModel *model = self.dataSources[indexPath.row];
    listCell.tLabel.text = [NSString stringWithFormat:@"%@ %@",model.accountLogType,model.nick];
    listCell.timeLabel.text = model.date;
    
    return listCell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 25)];
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, d_screen_width -20, view.height)];
        label.textColor =UIColorFromRGB(0x979797);
        label.font = textFont24;
        label.text = @"近期收支";
        [view addSubview:label];
        return view;
    }
    return nil;
}
@end
