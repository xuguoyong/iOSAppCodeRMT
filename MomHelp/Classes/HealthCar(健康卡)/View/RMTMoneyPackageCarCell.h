//
//  RMTMoneyPackageCarCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTCarPackageModel.h"
@interface RMTMoneyPackageCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *daijinquanLabel;
@property (weak, nonatomic) IBOutlet UIButton *transerButton;
@property (nonatomic,strong) RMTCarPackageModel *model;
//设置按钮的状态
- (void)setButtonColorWithStates:(BOOL)isShouldTransfer;

@property (nonatomic,strong) void(^transferButtonClickBlock)(id data);

@end
