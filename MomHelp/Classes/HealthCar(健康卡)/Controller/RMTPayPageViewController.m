//
//  RMTPayPageViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTPayPageViewController.h"
#import "RMTPayPageHeadCell.h"
#import "RMTSelectPayTypeCelll.h"


@interface RMTPayPageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *select;
@end

@implementation RMTPayPageViewController

-(NSMutableArray *)select
{
    if (!_select) {
        _select = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i < 5; i++) {
          [_select addObject:[NSNumber numberWithBool:NO]];
        }
      
    }
    return _select;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
     [self.tableView registerNib:[UINib nibWithNibName:@"RMTPayPageHeadCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"RMTSelectPayTypeCelll" bundle:nil] forCellReuseIdentifier:@"typeCell"];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
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
    
    return 5;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (d_screen_width-30)*(92/290.0f)+30+30+40;
    }
    if (indexPath.section == 1 &&indexPath.row ==0) {
        return 44.0f;
    }
    
    return 55.0f;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 200.0f;
    }
    return 0.001f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RMTPayPageHeadCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        headCell.timeLabel.text = [NSDate getCurrentStandarTimeWithFormatter:@"M月d日HH时mm分"];
        headCell.moneyLabel.text =@"主卡 ¥100";
        return headCell;
    }else if (indexPath.section ==1&&indexPath.row !=0 )
    {
        
        RMTSelectPayTypeCelll *typeCell = [tableView dequeueReusableCellWithIdentifier:@"typeCell"];
        NSString *imageName = nil;
        NSString *typeName = nil;
        if (indexPath.row ==1) {
            imageName = @"yinlian_icon";
            typeName = @"银联支付";
        }else if (indexPath.row == 2)
        {
            imageName = @"zhifubao_icon";
            typeName = @"支付宝支付";
        }else if (indexPath.row ==3)
        {
            imageName = @"yibo_icon";
            typeName = @"易宝支付";
        }else if (indexPath.row ==4)
        {
            imageName = @"yuezhifu_icon";
            typeName = @"余额支付";
        
        }
        
        if (![[self.select objectAtIndex:indexPath.row] boolValue]) {
          typeCell.selectImageView.image =[UIImage imageNamed:@"un_select_pay"];
        }else
        {
             typeCell.selectImageView.image = [UIImage imageNamed:@"select_pay"];
        }
        
        typeCell.typeImageView.image = [UIImage imageNamed:imageName];
        typeCell.typeName.text = typeName;
        return typeCell;
       
        
    
    }
    
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.textColor = UIColorFromRGB(0x868686);
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    cell.textLabel.text = @"选择支付方式";
    return cell;

    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 80)];
        UIButton *btn = [UIButton custombuttonNormalStateWithTitile:@"确认支付" titleFont:textFont32 titleColor:MainColor butttonImage:nil backgroundImage:nil backgroundColor:nil clickThingTarget:self action:@selector(comfirmPayButtonClick:)];
        btn.frame = CGRectMake(15, 30, d_screen_width - 30, 45);
        btn.layer.cornerRadius = 5.0f;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 0.5f;
        btn.layer.borderColor = MainColor.CGColor;
        [view addSubview:btn];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1&&indexPath.row != 0) {
        
        for (NSInteger i = 0; i < self.select.count; i ++) {
          [self.select replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
        }
        [self.select replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
       
        [self.tableView reloadData];
    }
    
}
- (void)comfirmPayButtonClick:(UIBarButtonItem *)bar
{

    
}

@end
