//
//  RMTApplyReimberViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTApplyReimberViewController.h"

@interface RMTApplyReimberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *toolBarView;
@property (nonatomic,strong) UILabel *toobarLabel;



@end

@implementation RMTApplyReimberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请结算";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    [self.view addSubview:self.toolBarView];
    
//    [self requestDataFromBack];
}

-(UIView *)toolBarView
{
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, d_screen_height - 64 -55, d_screen_width, 55)];
        UIButton *btn = [UIButton custombuttonNormalStateWithTitile:@"申请" titleFont:[UIFont systemFontOfSize:17.0f] titleColor:[UIColor whiteColor] butttonImage:nil backgroundImage:nil backgroundColor:MainColor clickThingTarget:self action:@selector(aplyButtonClick:)];
        btn.frame = CGRectMake(_toolBarView.width - 120, 0, 120, _toolBarView.height);
        [_toolBarView addSubview:btn];
        self.toobarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _toolBarView.width - 120, _toolBarView.height)];
        self.toobarLabel.text = @"申请结算¥ 00 治疗费用";
        self.toobarLabel.textColor = UIColorFromRGB(0x000000);
        self.toobarLabel.textAlignment = NSTextAlignmentCenter;
        self.toobarLabel.font = [UIFont systemFontOfSize:17.0f];
        [_toolBarView addSubview:self.toobarLabel];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 0.5)];
        view.backgroundColor = UIColorFromRGB(0xd2d2d2);
        [_toolBarView addSubview:view];
        
        
    }
    return _toolBarView;

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
 
    return 50.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试";
    return cell;

}
#pragma mark ===申请按钮的点击事件
-(void)aplyButtonClick:(UIButton *)sender
{

}


@end
