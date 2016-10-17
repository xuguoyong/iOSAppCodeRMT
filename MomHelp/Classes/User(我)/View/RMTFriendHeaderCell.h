//
//  RMTFriendHeaderCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTMainFriendModel.h"
@interface RMTFriendHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *receveMoney;
@property (weak, nonatomic) IBOutlet UILabel *frenidNumber;

@property (nonatomic,strong) RMTMainFriendModel *model;

@end
