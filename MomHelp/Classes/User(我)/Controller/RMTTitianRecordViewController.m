//
//  RMTTitianRecordViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTTitianRecordViewController.h"
#import "RMTTitianRecordCell.h"
@interface RMTTitianRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation RMTTitianRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现记录";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTTitianRecordCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMTTitianRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}


@end
