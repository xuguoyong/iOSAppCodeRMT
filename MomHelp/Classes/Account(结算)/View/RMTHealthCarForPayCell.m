//
//  RMTHealthCarForPayCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTHealthCarForPayCell.h"

@implementation RMTHealthCarForPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.CarImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
