//
//  RMTApprovalProcessCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTApprovalProcessCell.h"

@implementation RMTApprovalProcessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.remarkBgView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.remarkBgView.layer.masksToBounds = YES;
    self.remarkBgView.layer.cornerRadius = 6.0f;
    self.remarkBgView.layer.borderWidth = 0.5;
    self.remarkBgView.layer.borderColor = UIColorFromRGB(0xd2d2d2).CGColor;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
