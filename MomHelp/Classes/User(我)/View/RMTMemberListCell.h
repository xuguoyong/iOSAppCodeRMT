//
//  RMTMemberListCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTmyNewPeopListModel.h"
@interface RMTMemberListCell : UITableViewCell
@property (nonatomic,strong) RMTmyNewPeopListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@end
