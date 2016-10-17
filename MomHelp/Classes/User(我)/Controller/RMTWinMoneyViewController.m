//
//  RMTWinMoneyViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTWinMoneyViewController.h"
#import "HooDatePicker.h"
#import "RMTWinMoneyHeadCell.h"
#import "RMTWinMoneyCell.h"
#import "NSDate+Time.h"
#import "RMTcontrListModel.h"
@interface RMTWinMoneyViewController ()<HooDatePickerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HooDatePicker *datePicker;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSString *datString;
@property (nonatomic,strong) RMTcontrListModel *dataModel;




@end

@implementation RMTWinMoneyViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.datString = [NSDate getCurrentStandarTimeWithFormatter:@"yyyy年MM月"];
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
  
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTWinMoneyHeadCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTWinMoneyCell" bundle:nil] forCellReuseIdentifier:@"moneyCell"];

    self.title = @"收益";
    self.datePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
    self.datePicker.delegate = self;
    self.datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
    [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
    NSDate *maxDate = [NSDate date];
    NSDate *minDate = [dateFormatter dateFromString:@"1900-01-01"];
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
    [self requestDataFromBack:[NSDate getCurrentStandarTimeWithFormatter:@"yyyy"] month:[NSDate getCurrentStandarTimeWithFormatter:@"M"]];
    
  
}
- (void)requestDataFromBack:(NSString *)year month:(NSString *)month
{
    
    [RMTDataService getDataWithURL:GET_Friend_Profits parma:@{@"year":year,@"month":month} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
       self.dataModel = [RMTcontrListModel mj_objectWithKeyValues:[responseObj objectForKey:@"data"]];
        NSLog(@"%@",responseObj);
        [self.tableView reloadData];
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
    return self.dataModel.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 44.0f;
    }
    
   return  60.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        RMTWinMoneyHeadCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        headCell.timeLabel.text= self.datString;
        return headCell;
    }
    
    RMTWinMoneyCell *moneyCell = [tableView dequeueReusableCellWithIdentifier:@"moneyCell"];
    moneyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    moneyCell.model = self.dataModel.list[indexPath.row];
    return moneyCell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
        [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
      
        NSDate *minDate = [dateFormatter dateFromString:self.datString];
        [self.datePicker setDate:minDate animated:NO];
        [self.datePicker show];
    }
}

- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date
{
 
     self.datString = [NSDate dateToString:@"yyyy年MM月" byDate:date];
    
     [self requestDataFromBack:[NSDate dateToString:@"yyyy" byDate:date] month:[NSDate dateToString:@"M" byDate:date]];
    [self.tableView reloadData];
}


@end
