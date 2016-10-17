//
//  RMTFriendDistributingCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTFriendListModel.h"
@interface RMTFriendDistributingCell : UITableViewCell
@property (nonatomic,strong) RMTFriendListModel *model;

@property (weak, nonatomic) IBOutlet UILabel *one_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *one_rewardLabel;
@property (weak, nonatomic) IBOutlet UILabel *one_friend_number;
@property (weak, nonatomic) IBOutlet UILabel *one_moneyLabel;



@property (weak, nonatomic) IBOutlet UILabel *two_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *two_rewardLabel;
@property (weak, nonatomic) IBOutlet UILabel *two_friend_number;
@property (weak, nonatomic) IBOutlet UILabel *two_moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *three_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *three_rewardLabel;
@property (weak, nonatomic) IBOutlet UILabel *three_friend_number;
@property (weak, nonatomic) IBOutlet UILabel *three_moneyLabel;

@end
