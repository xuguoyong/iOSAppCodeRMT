//
//  RMTReceveDetailCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTcontrListModel.h"
@interface RMTReceveDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIView *backLine;

@property (weak, nonatomic) IBOutlet UIView *topLine;

@property (nonatomic,strong)RMTcontrListModel *model;
@end
