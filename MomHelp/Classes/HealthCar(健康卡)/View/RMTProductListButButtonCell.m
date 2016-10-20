//
//  RMTProductListButButtonCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTProductListButButtonCell.h"

@implementation RMTProductListButButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.buyButton.layer.cornerRadius = 5.0f;
    self.buyButton.layer.masksToBounds = YES;
    self.buyButton.layer.borderWidth = 0.5f;
    self.buyButton.layer.borderColor = MainColor.CGColor;
   
}

- (IBAction)buyButtonClick:(UIButton *)sender {
    
    if (self.buyButtonClickBock) {
        self.buyButtonClickBock(sender);
    }
}


@end
