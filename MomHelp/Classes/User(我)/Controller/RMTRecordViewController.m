//
//  RMTRecordViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTRecordViewController.h"
#import "RMTRecordListModel.h"
#import "NSDate+Time.h"
#import "RMTRecordDetailViewController.h"
#import "RMTAddhealthRecordViewController.h"

@interface RMTRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation RMTRecordViewController

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"健康档案";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
     self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithImageName:@"add_icon_white" highImageName:nil target:self action:@selector(rightButtonClick:)];
    [self requeestData];
}

- (void)requeestData
{
    __weak typeof(self)weakself =self;
    [RMTDataService getDataWithURL:GET_Record_List parma:nil showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        [self.dataSource removeAllObjects];
        self.dataSource = [RMTRecordListModel mj_objectArrayWithKeyValuesArray:[responseObj objectForKey:@"data"]];
        [weakself.tableView reloadData];
       
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];

}

- (void)rightButtonClick:(UIBarButtonItem *)bar
{
    RMTAddhealthRecordViewController *add= [[RMTAddhealthRecordViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    
    RMTRecordListModel *model =self.dataSource[indexPath.row];
    NSString *tameStame =[model.createdAt substringToIndex:10];
    cell.textLabel.text = [NSString stringWithFormat:@"%@病例档案",[NSDate  timestampChangesStandarTime:tameStame withFormatter:@"yyyy年M月d日"]];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMTRecordListModel *model =self.dataSource[indexPath.row];
    RMTRecordDetailViewController *detail = [[RMTRecordDetailViewController alloc] init];
    detail.detailModel = model;
    [self.navigationController pushViewController:detail animated:YES];

}
@end
