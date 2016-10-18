//
//  RMTUserInfoViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTUserInfoViewController.h"
#import "RMTUserInfoTableViewCell.h"
#import "RMTUserOtherTableViewCell.h"
#import "RMTUserCenterModel.h"
#import "UIBarButtonItem+Extension.h"
#import "RMTUserDetailInfoViewController.h"
#import "RMTRecordViewController.h"
#import "RMTMoneyViewController.h"
#import "RMTFreiendViewController.h"
#import "RMTSettingViewController.h"
#import "RMTMessageViewController.h"
#import "RMTShareAppViewController.h"

@interface RMTUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong)  RMTUserInfoModel *userModel;
@property (nonatomic,strong)  RMTUserCenterModel *centerModel;
@end

@implementation RMTUserInfoViewController


- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        [_dataSource addObject:@[@"个人信息"]];
         [_dataSource addObject:@[@"档案",@"钱包"]];
        [_dataSource addObject:@[@"人脉"]];
        [_dataSource addObject:@[@"消息"]];
        [_dataSource addObject:@[@"设置"]];
       
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTUserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"userInfo"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTUserOtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"other"];
    [self requestUserInfoFromBack];
    [self requestDataFromBack];
    
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
/**
    请求后台
 */
- (void)requestDataFromBack
{
    [RMTDataService getDataWithURL:GET_User_Center parma:nil showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        self.centerModel = [RMTUserCenterModel mj_objectWithKeyValues:[responseObj objectForKey:@"data"]];
        [self.tableView reloadData];
       
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
}

/**
    请求个人资料
 */
- (void)requestUserInfoFromBack
{
    [RMTDataService getDataWithURL:POST_GetUserInfo parma:nil showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        
        self.userModel = [RMTUserInfoModel shareInstance];
        [self.userModel setValuesForKeysWithDictionary:[responseObj objectForKey:@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.dataSource[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RMTUserInfoTableViewCell *user = [tableView dequeueReusableCellWithIdentifier:@"userInfo"];
        
        if ([RMTUserInfoModel shareInstance].HeadImage) {
            user.userHeader.image = [RMTUserInfoModel shareInstance].HeadImage;
        }else
        {
            [user.userHeader sd_setImageWithURL:[NSURL URLWithString:self.userModel.headPortrait] placeholderImage:nil];
        }
        user.userNikeNameLabel.text = self.userModel.nick;
        user.userMobileLabel.text = self.userModel.mobile;
        user.detailRLabel.text = [self.userModel.whetherCertification  intValue] == 1?@"已认证":@"未实名认证";
        if ([self.userModel.whetherCertification  intValue] == 1) {
            user.detailRLabel.text = @"已验证";
            user.authorimageView.hidden = NO;
        }else
        {
           user.detailRLabel.text = @"未实名验证";
              user.authorimageView.hidden = YES;
        }
        
        return user;
    }
    RMTUserOtherTableViewCell *other = [tableView dequeueReusableCellWithIdentifier:@"other"];
    other.className.text = self.dataSource[indexPath.section][indexPath.row];
    other.iconImageView.image = [self getImageWith:indexPath];
    other.rightLabel.hidden =  [self shouHiidenDetailLabel:indexPath cell:other];
    return other;

}

- (BOOL)shouHiidenDetailLabel:(NSIndexPath *)indexPath cell:(RMTUserOtherTableViewCell *) other
{
    switch (indexPath.section) {
        case 1:
        {
            if (indexPath.row ==0) {
                return YES;
            }else if (indexPath.row == 1)
            {
                other.rightLabel.text = [NSString stringWithFormat:@"¥ %@",self.centerModel.balance];
                return NO;
            }else
            {
                return YES;
            }
            
        }
            break;
        case 2:
        {
            return YES;
        }
            break;
        case 3:
        {
            other.rightLabel.text =[self.centerModel.noticeCount intValue] == 0?@"":self.centerModel.noticeCount;
            return NO;
        }
            break;
        case 4:
        {
            return YES;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (UIImage *)getImageWith:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
        {
            if (indexPath.row ==0) {
                return [UIImage imageNamed:@"record"];
            }else if (indexPath.row == 1)
            {
                return [UIImage imageNamed:@"money"];
            }else
            {
              return [UIImage imageNamed:@"collection"];
            }
            
        }
            break;
        case 2:
        {
            return [UIImage imageNamed:@"friend"];
        }
            break;
        case 3:
        {
            return [UIImage imageNamed:@"message"];
        }
            break;
        case 4:
        {
             return [UIImage imageNamed:@"setting"];
        }
            break;
            
        default:
            break;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0f;
    }
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 10.0f;
}
#pragma mark ===tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        RMTUserDetailInfoViewController *detail = [[RMTUserDetailInfoViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            RMTRecordViewController *detail = [[RMTRecordViewController alloc] init];
            [self.navigationController pushViewController:detail animated:YES];
        }else if (indexPath.row == 1)
        {
            RMTMoneyViewController *detail = [[RMTMoneyViewController alloc] init];
            [self.navigationController pushViewController:detail animated:YES];
        }
        
    }else if (indexPath.section == 2)
    {
        RMTFreiendViewController *detail = [[RMTFreiendViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    }else if (indexPath.section == 3)
    {
        RMTMessageViewController *detail = [[RMTMessageViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    }else if (indexPath.section == 4)
    {
        RMTSettingViewController *detail = [[RMTSettingViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    }
}
@end
