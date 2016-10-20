//
//  RMTReceveDetailCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTReceveDetailCell.h"
@implementation RMTReceveDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(RMTcontrListModel *)model
{
    _model = model;
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"defultHeadName"]];
    self.userNameLabel.text = model.nick;
    self.timeLabel.text = model.date;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"+ %.1f",[model.contrValue floatValue]];
    
    
}
@end
