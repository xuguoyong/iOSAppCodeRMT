//
//  RMTWinMoneyCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTWinMoneyCell.h"

@implementation RMTWinMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(RMTcontrListModel *)model
{
    _model = model;
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"defultHeadName"]];
    self.nameLabel.text = model.nick;
    self.timeLabel.text = model.date;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"+ %.1f",[model.contrValue floatValue]];
}
@end
