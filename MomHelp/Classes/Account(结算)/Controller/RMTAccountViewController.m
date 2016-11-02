//
//  RMTAccountViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTAccountViewController.h"
#import "RMTAccountHeadCell.h"
#import "RMTReimburListModel.h"
#import "RMTReiListCell.h"
#import "RMTApplyReimberViewController.h"
#import "RMTReplyDetailViewController.h"
@interface RMTAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSString *balance;
@property (nonatomic,strong) NSString *totalReimbursementWorth;
@property (nonatomic,strong) NSMutableArray *dataSources;


@end

@implementation RMTAccountViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTAccountHeadCell" bundle:nil] forCellReuseIdentifier:@"headeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTReiListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
     self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithImageName:@"add_icon_white" highImageName:nil target:self action:@selector(addButtonClick:)];
    
    [self requestDataFromBack];
     __weak typeof(self)weakself =self;
    [self.tableView addRefreshNormalHeaderWithRefreshBlock:^{
       [weakself requestDataFromBack];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginSuccess) name:NotificationUserLoginSuccess object:nil];
    
  
}

- (void)userLoginSuccess
{
    [self requestDataFromBack];
  
}

- (void)requestDataFromBack
{
    __weak typeof(self)weakself =self;
    
    [RMTDataService getDataWithURL:GET_Reimbursement_List parma:nil showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
    
        NSDictionary *data = [responseObj objectForKey:@"data"];
        weakself.balance = [data objectForKey:@"balance"];
        weakself.totalReimbursementWorth = [data objectForKey:@"totalReimbursementWorth"];
        weakself.dataSources = [RMTReimburListModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"reimbursementResponses"]];
        [weakself.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];

}

- (void)addButtonClick:(UIBarButtonItem *)bar
{
    
    RMTApplyReimberViewController *apply = [[RMTApplyReimberViewController alloc] init];
    apply.accountMoney =self.balance;
    apply.aplyjisuanSuccess = ^(id sata)
    {
        [self requestDataFromBack];
    };
    [self.navigationController pushViewController:apply animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }
    return self.dataSources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150.0f;
    }
    return 95.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RMTAccountHeadCell *headeCell = [tableView dequeueReusableCellWithIdentifier:@"headeCell"];
        headeCell.ReLabel.text = [NSString stringWithFormat:@"¥ %.2f",[self.balance floatValue]];
         headeCell.CumulativeLabel.text = [NSString stringWithFormat:@"¥ %.2f",[self.totalReimbursementWorth floatValue]];
        return headeCell;
    }
    
    RMTReimburListModel *model = self.dataSources[indexPath.row];
    RMTReiListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    listCell.timeLabel.text = model.date;
    listCell.tLbabel.text  =[NSString stringWithFormat:@"%@病历报告",model.recordDate];
    listCell.remarkLabel.text = model.remark;
    listCell.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.reimbursementWorth floatValue]];
    NSString *mType= nil;
    if ([model.type isEqualToString:@"physical"]) {
      mType =@"体检结算";
    }else if ([model.type isEqualToString:@"medical"])
    {
        mType =@"医疗结算";
    }else
    {
       mType =@"其他";
    }
    
    listCell.typeLabel.text = mType;
    NSString *mStatues = nil;
    if ([model.status isEqualToString:@"audit"]) {
        mStatues =@"审核中";
    }else if ([model.status isEqualToString:@"auditPass"])
    {
        mStatues =@"审核通过";
    }else if ([model.status isEqualToString:@"money"])
    {
        mStatues =@"打款中";
    }else if ([model.status isEqualToString:@"alreadyMoney"])
    {
        mStatues =@"已打款";
    }else if ([model.status isEqualToString:@"refuse"])
    {
        mStatues =@"审核未通过";
    }else
    {
        mStatues =@"其他";
    }
    
    listCell.stautesLabel.text = mStatues;
    
    return listCell;
    


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0)return;
    RMTReplyDetailViewController *detail = [[ RMTReplyDetailViewController alloc] init];
      RMTReimburListModel *model = self.dataSources[indexPath.row];
    detail.detailModel = model;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationUserLoginSuccess object:nil];
}
@end
