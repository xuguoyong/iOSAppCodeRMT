//
//  RMTMoneyPackageCarCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTMoneyPackageCarCell.h"

@implementation RMTMoneyPackageCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.transerButton setTitleColor:UIColorFromRGB(0x0963C) forState:UIControlStateNormal];
    [self.transerButton setTitleColor:UIColorFromRGB(0xD7000F) forState:UIControlStateSelected];
     [self.transerButton setTitle:@"转让中" forState:UIControlStateNormal];
     [self.transerButton setTitle:@"转让" forState:UIControlStateSelected];
    self.transerButton.layer.cornerRadius = 5.0f;
    self.transerButton.layer.masksToBounds = YES;
    self.transerButton.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setButtonColorWithStates:(BOOL)isShouldTransfer
{
    if (isShouldTransfer) {
       
        self.transerButton.selected = YES;
       
        self.transerButton.layer.borderColor =UIColorFromRGB(0xD7000F).CGColor;
        self.transerButton.enabled = YES;
       
    }else
    {
        self.transerButton.selected = NO;
        self.transerButton.enabled = NO;
        self.transerButton.layer.borderColor =[UIColor clearColor].CGColor;
    }
    
    
}
- (IBAction)transferButtonClick:(UIButton *)sender {
    
    if (self.transferButtonClickBlock) {
        self.transferButtonClickBlock(self.model);
    }
}

@end
