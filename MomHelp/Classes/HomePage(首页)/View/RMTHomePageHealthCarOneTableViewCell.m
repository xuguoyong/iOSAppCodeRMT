//
//  RMTHomePageHealthCarOneTableViewCell.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTHomePageHealthCarOneTableViewCell.h"
#import "RMTHomepageModel.h"
#import "RMTAdModel.h"
@interface RMTHomePageHealthCarOneTableViewCell ()
{
    UIImageView *_healthCarImageView;
}
@end

@implementation RMTHomePageHealthCarOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

/**
 创建UI
 */
- (void)createUI
{
    _healthCarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, d_screen_width - 20, (d_screen_width - 20)*(200/600.0f))];
    _healthCarImageView.contentMode = UIViewContentModeScaleAspectFill;
    _healthCarImageView.clipsToBounds = YES;
    [self.contentView addSubview:_healthCarImageView];
  
}

- (void)setModel:(RMTAdModel *)model
{
    [_healthCarImageView sd_setImageWithURL:[NSURL URLWithString:model.adImg] placeholderImage:[UIImage imageNamed:@"defult_health_big"]];

}
@end
