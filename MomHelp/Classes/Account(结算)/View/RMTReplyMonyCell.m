//
//  RMTReplyMonyCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTReplyMonyCell.h"

@implementation RMTReplyMonyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moneyTextFied.delegate = self;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.getHowmuchMoney) {
        self.getHowmuchMoney(self.moneyTextFied.text);
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![RMTTool isNumberRegex:string]) {
        return NO;
    }
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
