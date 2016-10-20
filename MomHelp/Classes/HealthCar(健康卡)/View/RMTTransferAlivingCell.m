//
//  RMTTransferAlivingCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTTransferAlivingCell.h"

@implementation RMTTransferAlivingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.fukaLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
