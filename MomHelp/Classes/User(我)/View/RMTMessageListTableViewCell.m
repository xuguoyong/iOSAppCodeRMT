//
//  RMTMessageListTableViewCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTMessageListTableViewCell.h"

@implementation RMTMessageListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(RMTMessageListModel *)model
{
    _model = model;
    self.timeLabel.text  = model.date;
    self.readView.hidden = [model.status intValue] == 0?NO:YES;
    self.messageContentLabel.text = model.title;
    
}

@end
