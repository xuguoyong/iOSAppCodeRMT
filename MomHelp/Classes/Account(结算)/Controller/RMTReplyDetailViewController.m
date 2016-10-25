//
//  RMTReplyDetailViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTReplyDetailViewController.h"
#import "RMTApprovalProcessCell.h"

@interface RMTReplyDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation RMTReplyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请记录";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"RMTApprovalProcessCell" bundle:nil] forCellReuseIdentifier:@"proCell"];
    
    
    
    [self requestDataFromBack];
}
- (void)requestDataFromBack
{
    __weak typeof(self)weakself =self;
    
    [RMTDataService getDataWithURL:GET_Reimbursement_Detail parma:@{@"reimbursementId":self.detailModel.reimbursementId} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        weakself.detailModel = [RMTReimburListModel mj_objectWithKeyValues:[responseObj objectForKey:@"data"]];
        [weakself.tableView reloadData];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 330.0f;
    }
    return 50.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
        
        RMTApprovalProcessCell *proCell = [tableView dequeueReusableCellWithIdentifier:@"proCell"];
        proCell.selectionStyle = UITableViewCellSelectionStyleNone;
        proCell.remarkTextView.text = self.detailModel.remark;
        proCell.secondDateLabel.hidden = YES;
        proCell.twoStauteLabel.hidden  =YES;
        proCell.threeDateLabel.hidden = YES;
        proCell.threeStauteLabel.hidden = YES;
        proCell.ToExamineImageView.image = [UIImage imageNamed:@"progress_icon_gray"];
        proCell.pendingMoneyImageView.image = [UIImage imageNamed:@"progress_icon_gray"];
        proCell.alreadyMoneyImageView.image = [UIImage imageNamed:@"progress_icon_gray"];
        
        NSString *mStatues = nil;
        if ([self.detailModel.status isEqualToString:@"audit"]) {
            
           proCell.ToExamineImageView.image = [UIImage imageNamed:@"progress_icon_green"];
            proCell.firstDateLabel.text = self.detailModel.date;
            proCell.firstStauteLabel.text  =@"审核中";
            
            
        }else if ([self.detailModel.status isEqualToString:@"auditPass"])
        {
           
            proCell.ToExamineImageView.image = [UIImage imageNamed:@"progress_icon_green"];
            proCell.firstDateLabel.text = self.detailModel.date;
            proCell.firstStauteLabel.text  =@"审核中通过";
        }else if ([self.detailModel.status isEqualToString:@"money"])
        {
            mStatues =@"打款中";
            proCell.ToExamineImageView.image = [UIImage imageNamed:@"progress_icon_green"];
            proCell.pendingMoneyImageView.image =[UIImage imageNamed:@"progress_icon_green"];
            proCell.leftProgressView.backgroundColor = UIColorFromRGB(0x2CDC00);
            proCell.firstDateLabel.text = self.detailModel.moneyDate;
            proCell.firstStauteLabel.text  =@"打款中";
            proCell.secondDateLabel.text = self.detailModel.date;
            proCell.twoStauteLabel.text  =@"审核通过";
            proCell.secondDateLabel.hidden = NO;
            proCell.twoStauteLabel.hidden = NO;
        }else if ([self.detailModel.status isEqualToString:@"alreadyMoney"])
        {
                     
            proCell.secondDateLabel.hidden = NO;
            proCell.threeDateLabel.hidden = NO;
            proCell.threeDateLabel.hidden = NO;
            proCell.twoStauteLabel.hidden = NO;
            
            
            proCell.ToExamineImageView.image = [UIImage imageNamed:@"progress_icon_green"];
            proCell.pendingMoneyImageView.image =[UIImage imageNamed:@"progress_icon_green"];
            proCell.leftProgressView.backgroundColor = UIColorFromRGB(0x2CDC00);
            proCell.alreadyMoneyImageView.image =[UIImage imageNamed:@"progress_icon_green"];
            proCell.rightProgressView.backgroundColor = UIColorFromRGB(0x2CDC00);
            
            proCell.firstDateLabel.text = self.detailModel.alreadyMoneyDate;
            proCell.firstStauteLabel.text  =@"已打款";
            proCell.secondDateLabel.text = self.detailModel.moneyDate;
            proCell.twoStauteLabel.text  =@"打款中";
            proCell.threeDateLabel.text = self.detailModel.date;
            proCell.threeStauteLabel.text  =@"审核通过";
            
            
        }else if ([self.detailModel.status isEqualToString:@"refuse"])
        {
            mStatues =@"审核未通过";
             proCell.ToExamineImageView.image = [UIImage imageNamed:@"progress_icon_red"];
            proCell.shenheLabel.textColor = UIColorFromRGB(0xFA0514);
            proCell.firstDateLabel.text = self.detailModel.alreadyMoneyDate;
            proCell.firstStauteLabel.text  =@"审核未通过";
            proCell.firstStauteLabel.textColor = UIColorFromRGB(0xFA0514);
        }
      
        return proCell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:17.0f];
        cell.detailTextLabel.textColor =UIColorFromRGB(0xFA0514);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0&& indexPath.row ==0) {
        NSString *mType= nil;
        if ([self.detailModel.type isEqualToString:@"physical"]) {
            mType =@"体检结算";
        }else if ([self.detailModel.type isEqualToString:@"medical"])
        {
            mType =@"医疗结算";
        }else
        {
            mType =@"其他";
        }
        cell.textLabel.text = mType;
        cell.detailTextLabel.hidden = YES;
        cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
        cell.textLabel.textColor = UIColorFromRGB(0x000000);
    }else if (indexPath.section == 1 && indexPath.row == 0)
    {
        cell.detailTextLabel.hidden = YES;
        cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
        cell.textLabel.textColor = UIColorFromRGB(0x000000); cell.textLabel.text  =[NSString stringWithFormat:@"%@病历报告",self.detailModel.recordDate];
        
        
    }else if (indexPath.section == 1 && indexPath.row ==1)
    {
        cell.detailTextLabel.hidden = NO;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %.2f",[self.detailModel.reimbursementWorth floatValue]];
        
        cell.textLabel.textColor = UIColorFromRGB(0x868686);
        cell.textLabel.text  =@"申请结算金额";
         cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    }
   
    return cell;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 45)];
    view.backgroundColor = UIColorFromRGB(0xebebeb);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, d_screen_width - 30, view.height)];
    [view addSubview:label];
    label.textColor =UIColorFromRGB(0x868686);
    label.font = [UIFont systemFontOfSize:14];
    if (section ==0) {
        label.text = @"结算选项";
    }else if (section == 1)
    {
        label.text = @"健康档案";
    }else
    {
        label.text = @"结算审批进度";
    }
    
    return view;
    
   
}
@end
