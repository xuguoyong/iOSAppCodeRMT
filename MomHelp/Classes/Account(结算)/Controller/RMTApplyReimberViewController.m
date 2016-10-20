//
//  RMTApplyReimberViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTApplyReimberViewController.h"
#import "RMTReimburListModel.h"
#import "RMTSelectHealthRecordCell.h"
#import "RMTAddMoreCell.h"
#import "NSDate+Time.h"
#import "RMTHealthCarForPayCell.h"
#import "RMTCarPackageModel.h"
#import "RMTReplyMonyCell.h"
#import "RMTCurrentMoneyDataCell.h"
@interface RMTApplyReimberViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *toolBarView;
@property (nonatomic,strong) UILabel *toobarLabel;
@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *reproDataSource;
@property (nonatomic,strong) NSMutableArray *carDateSurce;

@property (nonatomic,assign) int reportPage;
@property (nonatomic,assign) int carPage;


@end

@implementation RMTApplyReimberViewController

-(NSMutableArray *)reproDataSource
{
    if (!_reproDataSource) {
        _reproDataSource = [[NSMutableArray alloc] init];
    }
    return _reproDataSource;
}
-(NSMutableArray *)carDateSurce
{
    if (!_carDateSurce) {
        _carDateSurce = [[NSMutableArray alloc] init];
    }
    return _carDateSurce;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请结算";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTSelectHealthRecordCell" bundle:nil] forCellReuseIdentifier:@"healthCell"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"RMTAddMoreCell" bundle:nil] forCellReuseIdentifier:@"addCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"RMTHealthCarForPayCell" bundle:nil] forCellReuseIdentifier:@"carCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTReplyMonyCell" bundle:nil] forCellReuseIdentifier:@"moneyCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTCurrentMoneyDataCell" bundle:nil] forCellReuseIdentifier:@"accountCell"];
    
    
    
    

    [self.view addSubview:self.toolBarView];
    self.reportPage = 1;
    self.carPage = 1;
    [self requestDataFromBack];
}

-(UIView *)toolBarView
{
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, d_screen_height - 64 -55, d_screen_width, 55)];
        _toolBarView.backgroundColor = [UIColor whiteColor];
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
    
    [RMTDataService getDataWithURL:GET_HealthRecord_UserList parma:@{@"page":[NSString stringWithFormat:@"%d",self.carPage]} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        NSDictionary *data = [responseObj objectForKey:@"data"];
     weakself.dataSources = [RMTReimburListModel mj_objectArrayWithKeyValuesArray:data];
        [weakself addReportRcord];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
}


- (void)addReportRcord
{
  
    if (self.reproDataSource.count < self.dataSources.count) {
        int number = (int)self.reproDataSource.count;
        for (NSInteger i = number; i < self.dataSources.count; i ++) {
            [self.reproDataSource addObject:[self.dataSources objectAtIndex:i]];
            if ((int)self.reproDataSource.count - number == 2) {
                break;
            }
        }
        [self.tableView reloadData];
    }else
    {
        [SGShowMesssageTool showMessage:@"没有更多数据了..."];
    }
   
}

- (void)selectPayType
{
    
     __weak typeof(self)weakself =self;
    [RMTDataService getDataWithURL:GET_CardPackaget_List parma:@{@"page":[NSString stringWithFormat:@"%d",self.reportPage]} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSDictionary *data = [[[responseObj objectForKey:@"data"] objectForKey:@"cardPackageResponseBasePageable"] objectForKey:@"list"];
        NSMutableArray *arr =  [RMTCarPackageModel mj_objectArrayWithKeyValuesArray:data];
        [self.carDateSurce addObjectsFromArray:arr];
        
        [weakself.tableView reloadData];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.reproDataSource.count +1;
    }else if (section == 2)
    {
        return self.carDateSurce.count +1;
    }else if (section == 3)
    {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 0.0001f;
    }
    return 35.0f;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==2) {
        return 0.25f;
    }
    if (section == 3) {
        return 216+50;
    }
    return 0.0001f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row != self.carDateSurce.count) {
      
        return 100.0f;
    }else if (indexPath.section == 3 && indexPath.row ==0)
    {
        return 75.0f;
    }else if (indexPath.section == 3 && indexPath.row ==1)
    {
        return 250.0f;
    }
    
    return 50.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
        }
        cell.textLabel.text = @"病例档案";
        return cell;
    }else if (indexPath.section == 1)
    {
        
        if (indexPath.row == self.reproDataSource.count) {
            RMTAddMoreCell *addCell = [tableView dequeueReusableCellWithIdentifier:@"addCell"];
            addCell.tipsLabel.text = @"查看更多";
            return addCell;
        }else
        {
            
            RMTSelectHealthRecordCell *healthCell = [tableView dequeueReusableCellWithIdentifier:@"healthCell"];
            RMTReimburListModel *healthModel =self.reproDataSource [indexPath.row];
             NSString *tameStame =[healthModel.createdAt substringToIndex:10];
            healthCell.tLabel.text =[NSString stringWithFormat:@"%@病例档案",[NSDate  timestampChangesStandarTime:tameStame withFormatter:@"yyyy年M月d日"]];
           
            if (healthModel.isSelect) {
                healthCell.selectImageView.image = [UIImage imageNamed:@"select_icon"];
            }else
            {
                healthCell.selectImageView.image = [UIImage imageNamed:@"un_select_icon"];
            }
            
            return healthCell;
           
        }
    
    }else if (indexPath.section ==2)
    {
        
        if (indexPath.row == self.carDateSurce.count) {
            RMTAddMoreCell *addCell = [tableView dequeueReusableCellWithIdentifier:@"addCell"];
            addCell.tipsLabel.text = @"健康卡支付";
            
            return addCell;
        }else
        {
             RMTCarPackageModel *carModel =self.carDateSurce [indexPath.row];
            
            RMTHealthCarForPayCell *carCell = [tableView dequeueReusableCellWithIdentifier:@"carCell"];
            [carCell.CarImageView sd_setImageWithURL:[NSURL URLWithString:carModel.image] placeholderImage:[UIImage imageNamed:@"defult_banner"]];
            carCell.tLabel.text = carModel.title;
            carCell.numberLabel.text = carModel.number;
            carCell.CashCouponLabel.text = [NSString stringWithFormat:@"%.0f%%",[carModel.weekIncrement floatValue]*100];
            carCell.currentLabel.text = [NSString stringWithFormat:@"¥ %@",carModel.currentValue];
            
            if (carModel.isSelect) {
                carCell.selectImageView.image = [UIImage imageNamed:@"select_icon"];
            }else
            {
                carCell.selectImageView.image = [UIImage imageNamed:@"un_select_icon"];
            }
            
            return carCell;
        }
        
    }else if (indexPath.section ==3)
    {
        if (indexPath.row ==0) {
            RMTReplyMonyCell *moneyCell = [tableView dequeueReusableCellWithIdentifier:@"moneyCell"];
            return moneyCell;
            
        }else if (indexPath.row == 1)
        {
        
            RMTCurrentMoneyDataCell *accountCell = [tableView dequeueReusableCellWithIdentifier:@"accountCell"];
            return accountCell;

        }
    
    
    }
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试";
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return nil;
    }
    
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
        label.text = @"结算支付方式";
    }
    
    return view;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == self.reproDataSource.count) {
          [self addReportRcord];
        }else
        {
            for (RMTReimburListModel *model in self.reproDataSource) {
                model.isSelect  =NO;
            }
            RMTReimburListModel *healthModel =self.reproDataSource [indexPath.row];
            
            healthModel.isSelect = YES;
            [self.tableView reloadData];
        }
        
    }else if (indexPath.section ==2)
    {
        
        if (indexPath.row == self.carDateSurce.count && self.carDateSurce.count == 0) {
            self.carPage = 1;
            [self selectPayType];
        }else if (indexPath.row == self.carDateSurce.count)
        {
            self.carPage ++;
            [self selectPayType];
        }
        else
        {
            RMTCarPackageModel *carModel =self.carDateSurce [indexPath.row];
            
            carModel.isSelect = !carModel.isSelect;
            
        }
            [self.tableView reloadData];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark ===申请按钮的点击事件
-(void)aplyButtonClick:(UIButton *)sender
{

}


@end
