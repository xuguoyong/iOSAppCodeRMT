//
//  RMTBankCarViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTBankCarViewController.h"
#import "RMTBankCarCell.h"
@interface RMTBankCarViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSMutableArray *contentData;

@end

@implementation RMTBankCarViewController

-(NSMutableArray *)contentData
{
    if (!_contentData) {
        _contentData = [[NSMutableArray alloc] init];
        [_contentData addObject:@""];
         [_contentData addObject:@""];
         [_contentData addObject:@""];
         [_contentData addObject:@""];
         [_contentData addObject:@""];
        
    }
    return _contentData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@[@"姓名",@"身份证号"],@[@"银行",@"开户支行(XX分行XX支行)",@"卡号"]];
    self.title  =@"银行卡";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTBankCarCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr =self.dataSource[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMTBankCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        cell.contentTextField.tag = indexPath.row == 0?100:101;
    }else
    {
        if (indexPath.row == 0) {
          cell.contentTextField.tag = 102;
        }else
        {
        cell.contentTextField.tag = indexPath.row == 1?103:104;
        }
    }
    cell.contentTextField.delegate = self;
    cell.contentTextField.placeholder  =self.dataSource[indexPath.section][indexPath.row];
    
    
    
    return cell;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%ld",textField.tag);
    
    switch (textField.tag) {
        case 100:
        {
        
        }
            break;
        case 101:
        {
            
        }
            break;
        case 102:
        {
            
        }
            break;
        case 103:
        {
            
        }
            break;
        case 104:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    [self.contentData replaceObjectAtIndex:(textField.tag - 100) withObject:textField.text];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section ==1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 100)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 50)];
        label.textColor = UIColorFromRGB(0x868686);
        label.font =[UIFont systemFontOfSize:14.0f];
        label.text = @"认证后不可变更，认证人需与持卡人保持一致";
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
        UIButton *commit = [UIButton setMainButtonWithTitle:@"提交" clickThingTarget:self action:@selector(commitButtonClickCustom:)];
        commit.frame = CGRectMake(15, CGRectGetMaxY(label.frame), d_screen_width - 30, 45);
        [view addSubview:commit];
        
        return view;
    }
    return nil;
}

- (void)commitButtonClickCustom:(UIButton *)sender
{
    

    NSString *name = [self.contentData objectAtIndex:0];
     NSString *carID = [self.contentData objectAtIndex:1];
     NSString *bankName = [self.contentData objectAtIndex:2];
     NSString *kaihuhang = [self.contentData objectAtIndex:3];
    NSString *carNumber = [self.contentData objectAtIndex:4];
   
    if ([name isEqualToString:@""]) {
       [SGShowMesssageTool showMessage:@"请填写您的姓名"];
    }else if (![RMTTool checkUserIdCard:carID])
    {
     [SGShowMesssageTool showMessage:@"身份证号码不正确，请重新输入"];
    }else if ([bankName isEqualToString:@""])
    {
        [SGShowMesssageTool showMessage:@"请填写您的银行名称"];
    }else if ([kaihuhang isEqualToString:@""])
    {
        [SGShowMesssageTool showMessage:@"请填写开户行"];
    }else if ([carNumber isEqualToString:@""])
    {
        [SGShowMesssageTool showMessage:@"请填写卡号"];
    }else
    {
        for (NSString *string in self.contentData) {
            NSLog(@"%@",string);
        }
    
    }
    
    

    
    
}


@end
