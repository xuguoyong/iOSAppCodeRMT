//
//  RMTMemberViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTMemberViewController.h"
#import "RMTMemberListCell.h"
#import "RMTMemberHeaderTableViewCell.h"
#import "RMTFriendDistributingCell.h"
#import "RMTShareAppViewController.h"
@interface RMTMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation RMTMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"成员";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTMemberListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTMemberHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"userheadCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTFriendDistributingCell" bundle:nil] forCellReuseIdentifier:@"friendHeaderCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"shareIcon" highImageName:nil target:self action:@selector(shareButtonClick:)];
}


/**
 分享按钮的点击事件
 
 @param bar
 */
- (void)shareButtonClick:(UIButton *)bar
{
    NSLog(@"分享按钮");
    
    
    RMTShareAppViewController *share = [[RMTShareAppViewController alloc] init];
    share.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    share.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.7];
    
    share.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self  presentViewController:share animated:YES completion:^(void){
        share.view.superview.backgroundColor = [UIColor clearColor];
        
    }];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 1 || section == 0) {
        return 1;
    }
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
         return 94.0f;
    }else if (indexPath.section ==1)
    {
      return 240.0f;
    }
    return 66.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.001f;
    }
    return 10.0f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 25.0f;
    }
    return 0.001f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
       RMTMemberHeaderTableViewCell *userheadCell = [tableView dequeueReusableCellWithIdentifier:@"userheadCell"];
        
        return userheadCell;
    }else if (indexPath.section ==1)
        {
     RMTFriendDistributingCell *friendHeaderCell = [tableView dequeueReusableCellWithIdentifier:@"friendHeaderCell"];
            
            return friendHeaderCell;
    }
    
    
    
    RMTMemberListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    return listCell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==2) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 25)];
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, d_screen_width -20, view.height)];
        label.textColor =UIColorFromRGB(0x979797);
        label.font = textFont24;
        label.text = @"新成员";
        [view addSubview:label];
        return view;
    }
    return nil;
}


@end
