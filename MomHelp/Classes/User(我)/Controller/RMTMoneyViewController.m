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
#import "RMTMenueCell.h"
#import "RMTTitianRecordViewController.h"
#import "RMTWinRecordViewController.h"
#import "RMTTransPasswordFirstViewController.h"
#import "RMTChangeTransPasswdViewController.h"
#import "RMTTitianViewController.h"
#import "RMTBankCarViewController.h"
#import "RMTPutUserIDCarViewController.h"

#define isMenue tableView == self.menuetableView
@interface RMTMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) RMTMoneyModel *dataModel;
@property (nonatomic,strong) UITableView *menuetableView;
@property (nonatomic,strong) UIView *menueBgView;

@property (nonatomic,strong) UIImageView *menueImageView;
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
     self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithImageName:@"menue_icon" highImageName:nil target:self action:@selector(rightButtonClick:)];
    self.tableView  = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    self.tableView.separatorColor = UIColorFromRGB(0xd2d2d2);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTMoneyHeaderCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTReceveMoneyListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    __weak typeof(self)weakself =self;
    [self.tableView addRefreshNormalHeaderWithRefreshBlock:^{
        [weakself requestDataFromBack];
    }];
    [self requestDataFromBack];
    [self.view addSubview:self.menueImageView];
    self.menueImageView.hidden = YES;
}
- (UIImageView *)menueImageView
{
    if (!_menueImageView) {
        _menueImageView = [[UIImageView alloc] initWithFrame:CGRectMake(d_screen_width -10-150, 5, 150,150)];
        _menueImageView.image = [UIImage imageNamed:@"menueBgImageView"];
        
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.frame = CGRectMake(0, 15, _menueImageView.width, _menueImageView.height);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [tableView registerNib:[UINib nibWithNibName:@"RMTMenueCell" bundle:nil] forCellReuseIdentifier:@"menueCell"];
        tableView.bounces = NO;
        [_menueImageView addSubview:tableView];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorColor = [UIColor whiteColor];
        self.menuetableView = tableView;
        _menueImageView.userInteractionEnabled = YES;
    }
    return _menueImageView;
}


- (void)rightButtonClick:(UIBarButtonItem *)bar
{
    self.menueImageView.hidden = !self.menueImageView.hidden;
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
    if (isMenue) {
        return 1;
    }
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isMenue) {
        return 3;
    }
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
    if (isMenue) {
        return 0.0001f;
    }
    if (section == 0) {
        return 0.0001f;
    }
    return 25.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isMenue) {
        return 44.0f;
    }
    if (indexPath.section == 0) {
        return 200.0f;
    }
    return 65.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (isMenue) {
        RMTMenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menueCell"];
        
        if (indexPath.row ==2) {
            cell.lineView.hidden = YES;
        }else
        {
            cell.lineView.hidden = NO;
        }
        
        NSDictionary *dic =[self getMenueTitleAndIconWithIndexPath:indexPath];
        cell.typeLabel.text = [[dic allKeys] firstObject];
        cell.typeImageView.image = [dic objectForKey:[[dic allKeys] firstObject]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (indexPath.section == 0) {
        
      RMTMoneyHeaderCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        headCell.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[self.dataModel.balance floatValue]];
        headCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        __weak typeof(self)weakself= self;
        headCell.bankCarButtonClick = ^(id data)
        {
            [weakself bankButtonClick:data];
        
        };
        headCell.tixianButtonClick = ^(id data)
        {
            [weakself tixianButtonClick:data];
        };
        return headCell;
    }
     RMTReceveMoneyListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
     listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    RMTMoneyModel *model = self.dataSources[indexPath.row];
    listCell.tLabel.text = [NSString stringWithFormat:@"%@ %@",model.accountLogTypeName,model.nick];
    listCell.timeLabel.text = model.date;
    listCell.moneyLabel.text = model.money;
    if ([model.money floatValue] < 0) {
        listCell.moneyLabel.textColor = [UIColor redColor];
    }else
    {
     listCell.moneyLabel.textColor = MainColor;
    }
    
    return listCell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isMenue) {
        
        [self menueListClickActionIndexPath:indexPath];
        return;
    }
    if (!self.menueImageView.hidden) {
        self.menueImageView.hidden = YES;
    }
    
}

#pragma mark ===银行卡按钮的点击事件
- (void)bankButtonClick:(UIButton *)sender
{
    
    
    RMTBankCarViewController *bank = [[RMTBankCarViewController alloc] init];
    [self.navigationController pushViewController:bank animated:YES];

}
#pragma mark===提现按钮的点击事件
- (void)tixianButtonClick:(UIButton *)sender
{
    if ([self.dataModel.whetherBankCard intValue] ==0) {
        [SGShowMesssageTool showMessage:@"请先绑定银行卡~"];
        return;
    }
    
    RMTTitianViewController *tixian = [[RMTTitianViewController alloc] initWithNibName:@"RMTTitianViewController" bundle:nil];
    tixian.dataModel = self.dataModel;
    __weak typeof(self)weakself =self;
    tixian.tixianLater = ^(id dta)
    {
        [weakself requestDataFromBack];
    };
    [self.navigationController pushViewController:tixian animated:YES];
}


#pragma mark -获取菜单

- (void)menueListClickActionIndexPath:(NSIndexPath *)indexPath
{
    if (!self.menueImageView.hidden) {
        self.menueImageView.hidden = YES;
    }
    if (indexPath.row == 0) {
        RMTTitianRecordViewController *member = [[RMTTitianRecordViewController alloc] init];
        
        [self.navigationController pushViewController:member animated:YES];
    }else if (indexPath.row == 1)
    {
        RMTWinRecordViewController *member = [[RMTWinRecordViewController alloc] init];
        [self.navigationController pushViewController:member animated:YES];
    }else if (indexPath.row ==2)
    {
        if ([self.dataModel.whetherBankCard intValue] ==0) {
            [SGShowMesssageTool showMessage:@"请先绑定银行卡~"];
            return;
        }
        
        if ([self.dataModel.whetherTransactionPassword intValue] ==0) {
            RMTChangeTransPasswdViewController *pass = [[RMTChangeTransPasswdViewController alloc] initWithNibName:@"RMTChangeTransPasswdViewController" bundle:nil];
            [self.navigationController pushViewController:pass animated:YES];
        }else
        {
            RMTPutUserIDCarViewController *pass = [[RMTPutUserIDCarViewController alloc] initWithNibName:@"RMTPutUserIDCarViewController" bundle:nil];
            [self.navigationController pushViewController:pass animated:YES];
            
        }
      
    }
    
}
- (NSDictionary *)getMenueTitleAndIconWithIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.row ==0) {
        return @{@"提现记录":[UIImage imageNamed:@"menue_tixian_record"]};
    }else if (indexPath.row ==1)
    {
        return @{@"收益记录":[UIImage imageNamed:@"menue_receve_record"]};
    }else if (indexPath.row ==2)
    {
        return @{@"交易密码":[UIImage imageNamed:@"menue_passwd"]};
    }
    return nil;
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
