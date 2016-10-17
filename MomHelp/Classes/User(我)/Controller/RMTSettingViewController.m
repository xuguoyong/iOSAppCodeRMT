//
//  RMTSettingViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTSettingViewController.h"
#import "RMTSettingTableViewCell.h"
#import "RMTHTMLViewController.h"
#import "RMTUserInfoModel.h"
#import "RMTAppAbountViewController.h"
#import "SGControllerTool.h"
#import "RMTIdeaFeelbackViewController.h"


@interface RMTSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation RMTSettingViewController


- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource =[[NSMutableArray alloc] init];
        [_dataSource addObject:@[@"推送消息"]];
        [_dataSource addObject:@[@"常见问题",@"意见反馈"]];
        [_dataSource addObject:@[@"清除缓存"]];
        [_dataSource addObject:@[@"关于"]];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTSettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    self.tableView.bounces = NO;
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
    RMTSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.tLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.rightLabel.hidden = YES;
    cell.discoverImage.hidden = YES;
    cell.notiSwitch.hidden = YES;
    if (indexPath.section == 0) {
          cell.notiSwitch.hidden = NO;
        
    }else if (indexPath.section == 2)
    {
        cell.rightLabel.hidden = NO;
        [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
            cell.rightLabel.text = [NSString stringWithFormat:@"%.2f M",totalSize/1024.0/1024];
            
        }];
        
    }else{
        cell.discoverImage.hidden = NO;
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 80.0f;
    }
    return 5.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {//常见问题
                RMTHTMLViewController *html = [[RMTHTMLViewController alloc] init];
                html.title = @"常见问题";
                html.urlString = @"http://m.91stjk.com/detail/questions.html";
                [self.navigationController pushViewController:html animated:YES];
            }else
            {
                RMTIdeaFeelbackViewController *iead = [[RMTIdeaFeelbackViewController alloc] init];
                [self.navigationController pushViewController:iead animated:YES];
                
            
            }
        }
            break;
        case 2://清除缓存
        {
            
            [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
                
                NSString *message = [NSString stringWithFormat:@"您确认清除%.2f M缓存吗？",totalSize/1024.0/1024];
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //清除内存缓存
                    [[SDImageCache sharedImageCache] clearMemory];
                    //清除磁盘缓存
                    [[SDImageCache sharedImageCache] clearDisk];
                    //清除系统网络请求时缓存的数据
                    [[NSURLCache sharedURLCache]removeAllCachedResponses];
                    [self.tableView reloadData];
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                
                [ac addAction:action1];
                [ac addAction:action2];
                [self presentViewController:ac animated:YES completion:nil];
                
                
            }];
        }
            break;
        case 3://关于
        {
            
            RMTAppAbountViewController *about = [[RMTAppAbountViewController alloc] initWithNibName:@"RMTAppAbountViewController" bundle:nil];
            [self.navigationController pushViewController:about animated:YES];
          
        }
            break;
            
        default:
            break;
    }
    
   
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 80)];
       UIButton *btn = [UIButton custombuttonNormalStateWithTitile:@"退出登录" titleFont:textFont32 titleColor:[UIColor whiteColor] butttonImage:nil backgroundImage:nil backgroundColor:MainColor clickThingTarget:self action:@selector(loginOutBurttonClick:)];
        btn.frame = CGRectMake(15, 30, d_screen_width - 30, 45);
        btn.layer.cornerRadius = 5.0f;
        btn.layer.masksToBounds = YES;
        [view addSubview:btn];
        
        return view;
    }
    return nil;
}

//退出登录按钮的点击事件
- (void)loginOutBurttonClick:(UIButton *)btn
{
    [RMTUserInfoModel clearAccountToken];
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:0];
    [SGControllerTool popToLoginControllerTarget:self.tabBarController];
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
