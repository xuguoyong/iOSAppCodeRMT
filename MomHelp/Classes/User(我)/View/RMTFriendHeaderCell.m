//
//  RMTFriendHeaderCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTFriendHeaderCell.h"

@implementation RMTFriendHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(RMTMainFriendModel *)model
{
    _model = model;
    
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:defultHeadName]];
    self.userNameLabel.text = model.nick;
    
    self.receveMoney.text = [NSString stringWithFormat:@"¥ %.2f",[model.sumProfit floatValue]];
    self.frenidNumber.text = model.sumContacts;
    
}

@end
