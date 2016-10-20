//
//  RMTMemberListCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTMemberListCell.h"

@implementation RMTMemberListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(RMTmyNewPeopListModel *)model
{
    if ([model.levelIndex intValue] ==1) {
        self.typeImageView.image = [UIImage imageNamed:@"one_friend"];
    }else if ([model.levelIndex intValue] ==2)
    {
         self.typeImageView.image = [UIImage imageNamed:@"tow_friend"];
    }else
    {
     self.typeImageView.image = [UIImage imageNamed:@"three_friend"];
        
    }
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:defultHeadName]];
    self.userNameLabel.text = model.nick;
    self.timeLabel.text = model.date;
    
}
@end
