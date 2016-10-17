//
//  RMTBuyHealthCarToolBar.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTBuyHealthCarToolBar.h"

@interface RMTBuyHealthCarToolBar ()
{
    UILabel *_nameLabel;
     UILabel *_priceLabel;
    UIButton *_buyButton;

}

@end

@implementation RMTBuyHealthCarToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xFFFFFF);
        [self CreateUI];
    }
    return self;
}
- (void)CreateUI
{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    [self addSubview:line];
    line.backgroundColor = UIColorFromRGB(0xD2D2D2);
    _buyButton = [UIButton custombuttonNormalStateWithTitile:@"购买" titleFont:textFont30 titleColor:UIColorFromRGB(0xFFFFFF) butttonImage:nil backgroundImage:nil backgroundColor:MainColor clickThingTarget:self action:@selector(buyButtonClick:)];
    _buyButton.frame = CGRectMake(self.width - 130, 0.5, 130, self.height);
    [self addSubview:_buyButton];
    
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.width - _buyButton.width, self.height/2.0f)];
   
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = textColor868686;
    _nameLabel.font = textFont24;
    [self addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height/2.0f -3, self.width - _buyButton.width, self.height/2.0f-0.5)];
   
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.textColor = textColor868686;
    _priceLabel.font = textFont30;
    [self addSubview:_priceLabel];

}

- (void)sethealthCarName:(NSString *)carName andPrice:(NSString *)price
{
     _priceLabel.text = price;
    _nameLabel.text = carName;
}


- (void)buyButtonClick:(UIButton *)btn
{
    if (self.buyButtonClick) {
        self.buyButtonClick(nil);
    }
}
@end
