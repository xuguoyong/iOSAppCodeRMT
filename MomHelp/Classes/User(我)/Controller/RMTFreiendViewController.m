//
//  RMTFreiendViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTFreiendViewController.h"
#import "RMTReceveDetailCell.h"
#import "RMTFriendHeaderCell.h"
#import "RMTMenueCell.h"
#import "RMTMemberViewController.h"
#import "RMTWinMoneyViewController.h"
#import "RMTHTMLViewController.h"
#import "RMTShareAppViewController.h"
#import "RMTMainFriendModel.h"
#define isMenue tableView == self.menuetableView

@interface RMTFreiendViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *menuetableView;
@property (nonatomic,strong) UIView *menueBgView;
@property (nonatomic,strong) RMTMainFriendModel *dataModel;


@property (nonatomic,strong) UIImageView *menueImageView;


@end

@implementation RMTFreiendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"人脉";
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithImageName:@"menue_icon" highImageName:nil target:self action:@selector(rightButtonClick:)];
    
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTReceveDetailCell" bundle:nil] forCellReuseIdentifier:@"receveDetailCell"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"RMTFriendHeaderCell" bundle:nil] forCellReuseIdentifier:@"friendHeaderCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.menueImageView];
    self.menueImageView.hidden = YES;
    __weak typeof(self)weakself= self;
     [weakself requestDataFromBack];
    [self.tableView addRefreshNormalHeaderWithRefreshBlock:^{
      [weakself requestDataFromBack];
    }];
    
}

- (void)requestDataFromBack
{

    [RMTDataService getDataWithURL:GET_Friend_Muenue parma:nil showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
       
    self.dataModel = [RMTMainFriendModel mj_objectWithKeyValues:[responseObj objectForKey:@"data"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];

}

- (UIImageView *)menueImageView
{
    if (!_menueImageView) {
        _menueImageView = [[UIImageView alloc] initWithFrame:CGRectMake(d_screen_width -10-150, 5, 150,200)];
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
        return 4;
    }
    if (section == 0) {
        return 1;
    }
    return self.dataModel.contrList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isMenue) {
        return 44.0f;
    }
    if (indexPath.section ==0) {
        return 192.0f;
    }
    return 100.0f;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (isMenue) {
        return 0.0001f;
    }
    
    if (section ==1) {
        return 40.0f;
    }
    return 0.001f;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (isMenue) {
        return 0.001f;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (isMenue) {
        RMTMenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menueCell"];
        
        if (indexPath.row ==3) {
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
    
    
    
    
    if (indexPath.section ==0) {
        RMTFriendHeaderCell *friendHeaderCell = [tableView dequeueReusableCellWithIdentifier:@"friendHeaderCell"];
        friendHeaderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        friendHeaderCell.model = self.dataModel;
        return friendHeaderCell;
    }
    RMTReceveDetailCell *receveDetailCell = [tableView dequeueReusableCellWithIdentifier:@"receveDetailCell"];
    receveDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    receveDetailCell.model = self.dataModel.contrList[indexPath.row];
    receveDetailCell.topLine.hidden = NO;
    receveDetailCell.backLine.hidden = NO;
    if (indexPath.row == 0) {
       receveDetailCell.topLine.hidden = YES;
    }
    
    return receveDetailCell;
    
  
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 35)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,view.width - 30 , view.height)];
        label.textColor = UIColorFromRGB(0x868686);
        label.text = @"近期人脉收益";
        label.font = textFont24;
        [view addSubview:label];
        
        return view;
    }
    return nil;

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView ==self.menuetableView) {
        return;
    }
    if (!self.menueImageView.hidden) {
        self.menueImageView.hidden = YES;
    }
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




#pragma mark -获取菜单

- (void)menueListClickActionIndexPath:(NSIndexPath *)indexPath
{
    if (!self.menueImageView.hidden) {
        self.menueImageView.hidden = YES;
    }

    if (indexPath.row == 0) {
        RMTMemberViewController *member = [[RMTMemberViewController alloc] init];
        [self.navigationController pushViewController:member animated:YES];
    }else if (indexPath.row == 1)
    {
        RMTWinMoneyViewController *money = [[RMTWinMoneyViewController alloc] init];
        [self.navigationController pushViewController:money animated:YES];
    }else if (indexPath.row ==2)
    {
        RMTHTMLViewController *html = [[RMTHTMLViewController alloc] init];
        html.title = @"说明";
        html.urlString = @"http://m.91stjk.com/detail/regular.html";
        [self.navigationController pushViewController:html animated:YES];
    }else
    {
        RMTShareAppViewController *share = [[RMTShareAppViewController alloc] init];
        share.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        share.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.7];
        share.shareURL = [NSString stringWithFormat:@"%@?userId=%@",self.dataModel.share,self.dataModel.userId];
        share.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self  presentViewController:share animated:YES completion:^(void){
            share.view.superview.backgroundColor = [UIColor clearColor];
            
        }];
    }
    
}


- (NSDictionary *)getMenueTitleAndIconWithIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row ==0) {
        return @{@"成员":[UIImage imageNamed:@"member_icon"]};
    }else if (indexPath.row ==1)
    {
     return @{@"收益":[UIImage imageNamed:@"receve_icon"]};
    }else if (indexPath.row ==2)
    {
     return @{@"说明":[UIImage imageNamed:@"shuoming_icon"]};
    }else if (indexPath.row ==3)
    {
         return @{@"分享":[UIImage imageNamed:@"share_icon"]};
    }
    return nil;
}


@end
