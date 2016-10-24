//
//  RMTCurrentMoneyDataCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTCurrentMoneyDataCell.h"

@implementation RMTCurrentMoneyDataCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.bgView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 6.0f;
    self.bgView.layer.borderWidth = 0.5;
    self.bgView.layer.borderColor = UIColorFromRGB(0xd2d2d2).CGColor;
    
    self.textView = [[RMTTextView alloc] init];
    self.textView.backgroundColor =[UIColor clearColor];
    self.textView.placehoder = @"备注";
    self.textView.delegate = self;
    [self.bgView addSubview:self.textView];
    self.textView.sd_layout.topSpaceToView(self.bgView,5).leftEqualToView(self.bgView).offset(5).rightSpaceToView(self.bgView,5).bottomSpaceToView(self.bgView,20);
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.getText) {
        self.getText(self.textView.text);
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
