//
//  RMTMemberHeaderTableViewCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTMemberHeaderTableViewCell.h"

@implementation RMTMemberHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(RMTFriendListModel *)model
{
    
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"defultHeadName"]];
    self.nameLabel.text = model.nick;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.sumProfit floatValue]];
    self.friendNumberLabel.text =[NSString stringWithFormat:@"人脉 %@",model.sumContacts] ;
}
@end
