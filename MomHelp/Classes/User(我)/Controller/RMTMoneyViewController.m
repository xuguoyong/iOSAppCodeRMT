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

@interface RMTMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView ;


@end

@implementation RMTMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"钱包";
    self.tableView  = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    self.tableView.separatorColor = UIColorFromRGB(0xd2d2d2);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTMoneyHeaderCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTReceveMoneyListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    
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
    
    return 20.0f;

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
        return headCell;
    }
     RMTReceveMoneyListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
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
