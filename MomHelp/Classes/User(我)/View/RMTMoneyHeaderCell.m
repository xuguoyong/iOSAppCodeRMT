//
//  RMTMoneyHeaderCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTMoneyHeaderCell.h"

@implementation RMTMoneyHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)bankCarButttonClick:(id)sender {
    if (self.bankCarButtonClick) {
        self.bankCarButtonClick(sender);
    }
}

- (IBAction)tixianButtonClick:(id)sender {
    if (self.tixianButtonClick) {
        self.tixianButtonClick(sender);
    }
}


@end
